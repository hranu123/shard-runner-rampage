// =====================================
// SAVE MOVEMENT DIRECTION
// =====================================

var moving = false;

if (keyboard_check(ord("W")))
{
    facing_dir = "up";
    moving = true;
}
else if (keyboard_check(ord("S")))
{
    facing_dir = "down";
    moving = true;
}
else if (keyboard_check(ord("A")))
{
    facing_dir = "left";
    moving = true;
}
else if (keyboard_check(ord("D")))
{
    facing_dir = "right";
    moving = true;
}

// =====================================
// GUN + MOVEMENT FACING DIRECTION
// Gun can control facing direction,
// but movement keys can override it
// =====================================

var moving = false;

var using_gun =
    global.equipped_weapon == "pistol" ||
    global.equipped_weapon == "rifle" ||
    global.equipped_weapon == "shotgun" ||
    global.equipped_weapon == "rpg";


// Check movement first
if (keyboard_check(ord("W")))
{
    facing_dir = "up";
    moving = true;
}
else if (keyboard_check(ord("S")))
{
    facing_dir = "down";
    moving = true;
}
else if (keyboard_check(ord("A")))
{
    facing_dir = "left";
    moving = true;
}
else if (keyboard_check(ord("D")))
{
    facing_dir = "right";
    moving = true;
}


// If holding a gun and NOT pressing movement keys,
// character faces where gun/mouse is aiming
if (using_gun && !moving)
{
    var aim_dir_step = point_direction(x, y - jump_z, mouse_x, mouse_y);

    if (aim_dir_step >= 45 && aim_dir_step < 135)
    {
        facing_dir = "up";
    }
    else if (aim_dir_step >= 135 && aim_dir_step < 225)
    {
        facing_dir = "left";
    }
    else if (aim_dir_step >= 225 && aim_dir_step < 315)
    {
        facing_dir = "down";
    }
    else
    {
        facing_dir = "right";
    }
}

// =====================================
// COOLDOWNS
// =====================================

if (jump_cooldown > 0) jump_cooldown--;
if (fly_cooldown > 0) fly_cooldown--;
if (sprint_cooldown > 0) sprint_cooldown--;

if (is_flying && fly_timer > 0)
{
    fly_timer--;
}


// =====================================
// SPRINT SYSTEM
// Hold Shift while moving
// =====================================

is_sprinting = false;

// Lock sprint if stamina is too low
if (stamina_current <= sprint_min_stamina)
{
    sprint_locked = true;
}

// Unlock sprint only after stamina recovers enough
if (stamina_current >= sprint_resume_stamina)
{
    sprint_locked = false;
}

// Sprint only if not locked
if (
    keyboard_check(vk_shift) &&
    moving &&
    !is_jumping &&
    !is_flying &&
    !sprint_locked &&
    sprint_cooldown <= 0
)
{
    is_sprinting = true;

    var_main_speed = var_main_sprint;
    var_main_animation_speed = var_sprint_animation;

    stamina_current -= sprint_stamina_drain;
}
else
{
    is_sprinting = false;

    var_main_speed = var_walk_speed;
    var_main_animation_speed = var_walk_animation;
}

// If stamina hits 0 while sprinting, stop sprint and start cooldown
if (stamina_current <= 0)
{
    stamina_current = 0;
    is_sprinting = false;
    sprint_locked = true;
    sprint_cooldown = sprint_cooldown_time;

    var_main_speed = var_walk_speed;
    var_main_animation_speed = var_walk_animation;
}

// =====================================
// SPACE HOLD TIMER
// =====================================

if (keyboard_check(vk_space))
{
    space_hold_timer++;
}
else
{
    space_hold_timer = 0;
}


// =====================================
// START JUMP
// Tap Space = jump once
// =====================================

if (keyboard_check_pressed(vk_space))
{
    if (!is_jumping && !is_flying && jump_cooldown <= 0 && stamina_current >= jump_stamina_cost)
    {
        is_jumping = true;
        is_flying = false;

        jump_timer = 0;
        jump_z = 0;

        stamina_current -= jump_stamina_cost;
        jump_cooldown = jump_cooldown_time;

        // Stop sprinting when jump begins
        is_sprinting = false;
        var_main_speed = var_walk_speed;
    }
}


// =====================================
// JUMP ARC
// =====================================

if (is_jumping && !is_flying)
{
    jump_timer++;

    var progress = jump_timer / jump_duration;

    jump_z = sin(progress * pi) * jump_height;

    if (jump_timer >= jump_duration)
    {
        is_jumping = false;
        jump_z = 0;
    }
}


// =====================================
// START FLYING
// Hold Space after jump = fly
// =====================================

if (is_jumping && keyboard_check(vk_space))
{
    if (
        space_hold_timer >= fly_hold_delay &&
        fly_cooldown <= 0 &&
        stamina_current >= fly_min_stamina
    )
    {
        is_jumping = false;
        is_flying = true;
        is_sprinting = false;

        jump_z = fly_height;
        fly_timer = fly_time_max;

        var_main_speed = var_walk_speed;
    }
}


// =====================================
// FLYING
// =====================================

if (is_flying)
{
    jump_z = fly_height;

    stamina_current -= fly_stamina_drain;

    if (keyboard_check(ord("W")))
    {
        y -= fly_speed;
        facing_dir = "up";
    }

    if (keyboard_check(ord("S")))
    {
        y += fly_speed;
        facing_dir = "down";
    }

    if (keyboard_check(ord("A")))
    {
        x -= fly_speed;
        facing_dir = "left";
    }

    if (keyboard_check(ord("D")))
    {
        x += fly_speed;
        facing_dir = "right";
    }

    if (!keyboard_check(vk_space) || fly_timer <= 0 || stamina_current <= 0)
    {
        is_flying = false;
        is_jumping = false;

        jump_z = 0;
        fly_cooldown = fly_cooldown_time;

        stamina_current = max(stamina_current, 0);
    }
}


// =====================================
// STAMINA RECOVERY
// =====================================

if (!is_sprinting && !is_flying)
{
    if (stamina_current < stamina_max)
    {
        stamina_current += stamina_recover_speed;
    }
}

stamina_current = clamp(stamina_current, 0, stamina_max);


// =====================================
// SPRITES
// =====================================

if (is_jumping || is_flying)
{
    if (facing_dir == "up") sprite_index = spr_main_character_up_fly;
    else if (facing_dir == "down") sprite_index = spr_main_character_down_fly;
    else if (facing_dir == "left") sprite_index = spr_main_character_left_fly;
    else if (facing_dir == "right") sprite_index = spr_main_character_right_fly;
}
else if (is_sprinting && stamina_current > sprint_min_stamina && !sprint_locked)
{
    if (facing_dir == "up") sprite_index = spr_main_character_up_sprint;
    else if (facing_dir == "down") sprite_index = spr_main_character_down_sprint;
    else if (facing_dir == "left") sprite_index = spr_main_character_left_sprint;
    else if (facing_dir == "right") sprite_index = spr_main_character_right_sprint;
}
else
{
    // Default back to normal walk/idle sprites
    if (facing_dir == "up") sprite_index = spr_main_character_up_walk;
    else if (facing_dir == "down") sprite_index = spr_main_character_down_walk;
    else if (facing_dir == "left") sprite_index = spr_main_character_left_walk;
    else if (facing_dir == "right") sprite_index = spr_main_character_right_walk;

    // Freeze only if standing still
    if (!moving)
    {
        image_index = 0;
    }
}
// INVENTORY + WEAPON SYSTEM
// =====================================


// SAFETY CHECK
if (!variable_global_exists("weapon_inventory"))
{
    global.weapon_inventory = [noone, noone, noone, noone, noone];
    global.selected_weapon_slot = -1;
    global.equipped_weapon = noone;
}


// SAFETY CHECK FOR PLAYER VARIABLES
if (!variable_instance_exists(id, "rifle_fire_cooldown"))
{
    rifle_fire_cooldown = 0;
}

if (!variable_instance_exists(id, "collect_message_timer"))
{
    collect_message_timer = 0;
}


// COUNT DOWN RIFLE FIRE COOLDOWN
if (rifle_fire_cooldown > 0)
{
    rifle_fire_cooldown--;
}


// COUNT DOWN COLLECT MESSAGE
if (collect_message_timer > 0)
{
    collect_message_timer--;
}


// RELOAD SYSTEM
if (keyboard_check_pressed(ord("R")) && !is_reloading)
{
    if (global.equipped_weapon == "pistol" && pistol_current_ammo < pistol_max_ammo)
    {
        is_reloading = true;
        reload_timer = pistol_reload_time;
}

    if (global.equipped_weapon == "rifle" && rifle_current_ammo < rifle_max_ammo)
    {
        is_reloading = true;
        reload_timer = rifle_reload_time;
    }
	 if (global.equipped_weapon == "shotgun" && shotgun_current_ammo <shotgun_max_ammo)
    {
        is_reloading = true;
        reload_timer = shotgun_reload_time;
} 
if (global.equipped_weapon == "rpg" && rpg_current_ammo <rpg_max_ammo)
    {
        is_reloading = true;
        reload_timer = rpg_reload_time;
}
}
if (is_reloading)
{
    reload_timer--;

    if (reload_timer <= 0)
    {
if (global.equipped_weapon == "pistol")
        {
            pistol_current_ammo = pistol_max_ammo;
        }
if (global.equipped_weapon == "rifle")
        {
            rifle_current_ammo = rifle_max_ammo;
        }
if (global.equipped_weapon == "shotgun")
        {
            shotgun_current_ammo = shotgun_max_ammo;
        }
if (global.equipped_weapon == "rpg")
        {
            rpg_current_ammo = rpg_max_ammo;
        }

        is_reloading = false;
}
}


// COLLECT PISTOL WITH V
var pistol = instance_place(x, y, obj_pistol_item);

if (pistol != noone && keyboard_check_pressed(ord("V")))
{
    for (var i = 0; i < 5; i++)
    {
        if (global.weapon_inventory[i] == noone)
        {
            global.weapon_inventory[i] = "pistol";
            global.selected_weapon_slot = i;
            global.equipped_weapon = "pistol";

            collect_message_timer = 120;

            with (pistol)
            {
                instance_destroy();
            }

            break;
        }
    }
}


// COLLECT RIFLE WITH V
var rifle = instance_place(x, y, obj_rifle_item);

if (rifle != noone && keyboard_check_pressed(ord("V")))
{
    for (var j = 0; j < 5; j++)
    {
        if (global.weapon_inventory[j] == noone)
        {
            global.weapon_inventory[j] = "rifle";
            global.selected_weapon_slot = j;
            global.equipped_weapon = "rifle";

            collect_message_timer = 120;

            with (rifle)
            {
                instance_destroy();
            }

            break;
        }
    }
}
// COLLECT SHOTGUN WITH V
var shotgun = instance_place(x, y, obj_shotgun_item);

if (shotgun != noone && keyboard_check_pressed(ord("V")))
{
    for (var j = 0; j < 5; j++)
    {
        if (global.weapon_inventory[j] == noone)
        {
            global.weapon_inventory[j] = "shotgun";
            global.selected_weapon_slot = j;
            global.equipped_weapon = "shotgun";

            collect_message_timer = 120;

            with (shotgun)
            {
                instance_destroy();
            }

            break;
        }
    }
}
// COLLECT RPG WITH V
var rpg = instance_place(x, y, obj_rpg_item);

if (rpg != noone && keyboard_check_pressed(ord("V")))
{
    for (var j = 0; j < 5; j++)
    {
        if (global.weapon_inventory[j] == noone)
        {
            global.weapon_inventory[j] = "rpg";
            global.selected_weapon_slot = j;
            global.equipped_weapon = "rpg";

            collect_message_timer = 120;

            with (rpg)
            {
                instance_destroy();
            }

            break;
        }
    }
}


// EQUIP WEAPON WITH NUMBER KEYS
if (keyboard_check_pressed(ord("1"))) global.selected_weapon_slot = 0;
if (keyboard_check_pressed(ord("2"))) global.selected_weapon_slot = 1;
if (keyboard_check_pressed(ord("3"))) global.selected_weapon_slot = 2;
if (keyboard_check_pressed(ord("4"))) global.selected_weapon_slot = 3;
if (keyboard_check_pressed(ord("5"))) global.selected_weapon_slot = 4;


// UPDATE EQUIPPED WEAPON
if (global.selected_weapon_slot != -1)
{
    global.equipped_weapon = global.weapon_inventory[global.selected_weapon_slot];
}


// SHOOT WEAPON
if (global.equipped_weapon != noone && !is_reloading)
{
    var dir = point_direction(x, y, mouse_x, mouse_y);

 // =====================================
// BULLET SPAWN POSITION
// Matches gun Draw Event position
// =====================================

var base_y = y - jump_z;

// Direction toward mouse
var dir = point_direction(x, base_y, mouse_x, mouse_y);


// Match hand position from Draw Event
var hand_x = x;
var hand_y = base_y;

if (facing_dir == "right")
{
    hand_x = x + 65;
    hand_y = base_y + 30;
}
else if (facing_dir == "left")
{
    hand_x = x + 4;
    hand_y = base_y + 45;
}
else if (facing_dir == "up")
{
    hand_x = x + 30;
    hand_y = base_y + 45;
}
else if (facing_dir == "down")
{
    hand_x = x + 30;
    hand_y = base_y + 60;
}


// Match gun Draw Event pull distance
var gun_distance = 4;

var gun_x = hand_x + lengthdir_x(gun_distance, dir);
var gun_y = hand_y + lengthdir_y(gun_distance, dir);


// Spawn bullet from end of weapon barrel
var barrel_distance = 42;

var bullet_x = gun_x + lengthdir_x(barrel_distance, dir);
var bullet_y = gun_y + lengthdir_y(barrel_distance, dir);


    // PISTOL - one shot per click
    if (global.equipped_weapon == "pistol")
    {
        if (mouse_check_button_pressed(mb_left) && pistol_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_pistol_bullet);

            bullet.direction = dir;
            bullet.speed = 12;

            pistol_current_ammo--;
        }
    }


    // RIFLE - hold mouse to shoot
    if (global.equipped_weapon == "rifle")
    {
        if (mouse_check_button(mb_left) && rifle_fire_cooldown <= 0 && rifle_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_rifle_bullet);

            bullet.direction = dir;
            bullet.speed = 18;

            rifle_current_ammo--;
            rifle_fire_cooldown = 6;
        }
    }
	// SHOTGUN - one shot per click
    if (global.equipped_weapon == "shotgun")
    {
        if (mouse_check_button_pressed(mb_left) && shotgun_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_shotgun_bullet);

            bullet.direction = dir;
            bullet.speed = 12;

           shotgun_current_ammo--;
        }
    }
	// RPG - one shot per click
    if (global.equipped_weapon == "rpg")
    {
        if (mouse_check_button_pressed(mb_left) && rpg_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_rpg_bullet);

            bullet.direction = dir;
            bullet.speed = 12;

           rpg_current_ammo--;
        }
    }
}
// =====================================
// SWORD ATTACK
// =====================================

if (global.equipped_weapon == "sword")
{
    if (mouse_check_button_pressed(mb_left) && !is_sword_attacking)
    {
        is_sword_attacking = true;
        sword_attack_timer = sword_attack_duration;
        // Reset sword animation frame only once when attack begins
        sword_attack_frame = 0;

        var hit_x = x;
        var hit_y = y;

        if (facing_dir == "up")
        {
            hit_y = y - sword_range;
        }
        else if (facing_dir == "down")
        {
            hit_y = y + sword_range;
        }
        else if (facing_dir == "left")
        {
            hit_x = x - sword_range;
        }
        else if (facing_dir == "right")
        {
            hit_x = x + sword_range;
        }

        var enemy = instance_place(hit_x, hit_y, obj_enemy);

        if (enemy != noone)
        {
            with (enemy)
            {
                hp -= other.sword_damage;

                if (hp <= 0)
                {
                    instance_destroy();
                }
            }
        }
    }
}


// =====================================
// SWORD ATTACK ANIMATION TIMER
// =====================================

if (is_sword_attacking)
{
    sword_attack_timer--;

    var is_moving =
        keyboard_check(ord("W")) ||
        keyboard_check(ord("A")) ||
        keyboard_check(ord("S")) ||
        keyboard_check(ord("D"));

    // Standing still = normal sword animation speed
    if (!is_moving)
    {
        sword_attack_frame += sword_attack_speed;
    }
    // Moving = slower sword frame increase to prevent double-speed effect
    else
    {
        sword_attack_frame += sword_attack_speed * 0.5;
    }

    if (sword_attack_timer <= 0)
    {
        is_sword_attacking = false;
        sword_attack_frame = 0;
    }
}