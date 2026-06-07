// =====================================
// SAVE MOVEMENT DIRECTION
// =====================================

mask_index = spr_main_character_right_walk;;

var moving = false;
var fly_moving = false;

var move_left = keyboard_check(ord("A"));
var move_right = keyboard_check(ord("D"));
var move_up = keyboard_check(ord("W"));
var move_down = keyboard_check(ord("S"));

if (move_left)
{
    facing_dir = "left";
    moving = true;
}
else if (move_right)
{
    facing_dir = "right";
    moving = true;
}


// =====================================
// GUN + MOVEMENT FACING DIRECTION
// Gun controls facing only when not moving or flying
// =====================================

var using_gun =
    global.equipped_weapon == "pistol" ||
    global.equipped_weapon == "rifle" ||
    global.equipped_weapon == "shotgun" ||
    global.equipped_weapon == "rpg";

if (using_gun && !moving && !is_flying)
{
    if (mouse_x < x)
    {
        facing_dir = "left";
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
// GRAVITY SYSTEM
// =====================================

is_grounded = place_meeting(x, y + 1, obj_ground);

if (is_grounded)
{
    is_falling = false;

    if (vsp > 0)
    {
        vsp = 0;
    }
}
else
{
    is_grounded = false;
}

if (!is_grounded && !is_flying)
{
    vsp += gravity_force;

    if (vsp > max_fall_speed)
    {
        vsp = max_fall_speed;
    }

    is_falling = true;
}

if (!is_flying)
{
    if (vsp != 0)
    {
        if (place_meeting(x, y + vsp, obj_ground))
        {
            while (!place_meeting(x, y + sign(vsp), obj_ground))
            {
                y += sign(vsp);
            }

            vsp = 0;
            is_grounded = place_meeting(x, y + 1, obj_ground);
            is_falling = false;
            is_jumping = false;
        }
        else
        {
            y += vsp;
        }
    }
}


// =====================================
// SPRINT SYSTEM
// =====================================

is_sprinting = false;

if (stamina_current <= sprint_min_stamina)
{
    sprint_locked = true;
}

if (stamina_current >= sprint_resume_stamina)
{
    sprint_locked = false;
}

if (
    keyboard_check(vk_shift) &&
    moving &&
    is_grounded &&
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
// HORIZONTAL MOVEMENT
// Disabled while flying
// =====================================

if (!is_flying)
{
    var hsp = 0;

    if (move_left)
    {
        hsp = -var_main_speed;
    }

    if (move_right)
    {
        hsp = var_main_speed;
    }

    if (hsp != 0)
    {
        if (!place_meeting(x + hsp, y, obj_ground))
        {
            x += hsp;
        }
        else
        {
            while (!place_meeting(x + sign(hsp), y, obj_ground))
            {
                x += sign(hsp);
            }
        }
    }
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
// =====================================

if (keyboard_check_pressed(vk_space))
{
    if (is_grounded && !is_flying && jump_cooldown <= 0 && stamina_current >= jump_stamina_cost)
    {
        vsp = jump_force;

        is_jumping = true;
        is_falling = false;
        is_flying = false;
        is_grounded = false;

        stamina_current -= jump_stamina_cost;
        jump_cooldown = jump_cooldown_time;

        is_sprinting = false;
        var_main_speed = var_walk_speed;
    }
}


// =====================================
// JUMP STATE
// =====================================

if (is_grounded)
{
    is_jumping = false;
}

if (!is_grounded && vsp > 0 && !is_flying)
{
    is_falling = true;
}


// =====================================
// START FLYING
// =====================================

if (!is_grounded && keyboard_check(vk_space))
{
    if (
        space_hold_timer >= fly_hold_delay &&
        fly_cooldown <= 0 &&
        stamina_current >= fly_min_stamina &&
        !is_flying
    )
    {
        is_jumping = false;
        is_falling = false;
        is_flying = true;
        is_sprinting = false;

        is_fly_lifting = true;
        fly_lift_timer = fly_lift_time;

        vsp = 0;
        fly_timer = fly_time_max;

        fly_anim_frame = 0;
        last_fly_sprite = noone;

        facing_dir = "up";

        var_main_speed = var_walk_speed;
    }
}


// =====================================
// FLYING
// Lift upward first, then allow control
// =====================================

if (is_flying)
{
    vsp = 0;

    stamina_current -= fly_stamina_drain;

    var fly_hsp = 0;
    var fly_vsp = 0;

    if (is_fly_lifting)
    {
        fly_vsp = -fly_lift_speed;
        facing_dir = "up";

        fly_lift_timer--;

        if (fly_lift_timer <= 0)
        {
            is_fly_lifting = false;
        }
    }
    else
    {
        if (move_left)
        {
            fly_hsp = -fly_speed;
            facing_dir = "left";
            fly_moving = true;
        }

        if (move_right)
        {
            fly_hsp = fly_speed;
            facing_dir = "right";
            fly_moving = true;
        }

        if (move_up)
        {
            fly_vsp = -fly_speed;
            facing_dir = "up";
            fly_moving = true;
        }

        if (move_down)
        {
            fly_vsp = fly_speed;
            facing_dir = "down";
            fly_moving = true;
        }
    }

    if (fly_hsp != 0)
    {
        if (!place_meeting(x + fly_hsp, y, obj_ground))
        {
            x += fly_hsp;
        }
        else
        {
            while (!place_meeting(x + sign(fly_hsp), y, obj_ground))
            {
                x += sign(fly_hsp);
            }
        }
    }

    if (fly_vsp != 0)
    {
        if (!place_meeting(x, y + fly_vsp, obj_ground))
        {
            y += fly_vsp;
        }
        else
        {
            while (!place_meeting(x, y + sign(fly_vsp), obj_ground))
            {
                y += sign(fly_vsp);
            }
        }
    }

    if (!keyboard_check(vk_space) || fly_timer <= 0 || stamina_current <= 0)
    {
        is_flying = false;
        is_jumping = false;
        is_falling = true;
        is_fly_lifting = false;

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
// Smooth sprint animation fix
// =====================================

var new_sprite = sprite_index;
var new_speed = 0;
var manual_animation = false;


// FLYING
if (is_flying)
{
    if (facing_dir == "up") new_sprite = spr_main_character_up_fly;
    else if (facing_dir == "down") new_sprite = spr_main_character_down_fly;
    else if (facing_dir == "left") new_sprite = spr_main_character_left_fly;
    else new_sprite = spr_main_character_right_fly;

    new_speed = 0;
    manual_animation = true;
}

// FALLING
else if (is_falling)
{
    new_sprite = spr_main_character_down_fly;
    new_speed = 0;
    manual_animation = true;
}

// JUMPING
else if (is_jumping)
{
    if (facing_dir == "left") new_sprite = spr_main_character_left_fly;
    else new_sprite = spr_main_character_right_fly;

    new_speed = fly_animation_speed;
}

// SPRINTING
else if (is_sprinting && moving && is_grounded)
{
    if (facing_dir == "left") new_sprite = spr_main_character_left_sprint;
    else new_sprite = spr_main_character_right_sprint;

    new_speed = var_sprint_animation;
}

// WALK / IDLE
else
{
    if (facing_dir == "left") new_sprite = spr_main_character_left_walk;
    else new_sprite = spr_main_character_right_walk;

    if (moving)
    {
        new_speed = var_walk_animation;
    }
    else
    {
        new_speed = 0;
    }
}


// =====================================
// APPLY SPRITE SMOOTHLY
// =====================================

if (sprite_index != new_sprite)
{
    sprite_index = new_sprite;

    if (image_index >= sprite_get_number(sprite_index))
    {
        image_index = 0;
    }

    if (manual_animation)
    {
        fly_anim_frame = image_index;
        last_fly_sprite = sprite_index;
    }
}

image_speed = new_speed;


// =====================================
// MANUAL FLY / FALL FRAME CONTROL ONLY
// =====================================

if (manual_animation)
{
    fly_anim_frame += fly_animation_speed;

    if (fly_anim_frame >= sprite_get_number(sprite_index))
    {
        fly_anim_frame = 0;
    }

    image_index = fly_anim_frame;
}


// =====================================
// IDLE FRAME RESET ONLY
// =====================================

if (!moving && !is_flying && !is_falling && !is_jumping && !is_sprinting)
{
    image_index = 0;
}


// =====================================
// INVENTORY + WEAPON SYSTEM
// =====================================

if (!variable_global_exists("weapon_inventory"))
{
    global.weapon_inventory = [noone, noone, noone, noone, noone];
    global.selected_weapon_slot = -1;
    global.equipped_weapon = noone;
}


// =====================================
// SAFETY CHECK FOR PLAYER VARIABLES
// =====================================

if (!variable_instance_exists(id, "rifle_fire_cooldown"))
{
    rifle_fire_cooldown = 0;
}

if (!variable_instance_exists(id, "collect_message_timer"))
{
    collect_message_timer = 0;
}


// =====================================
// COUNTDOWNS
// =====================================

if (rifle_fire_cooldown > 0)
{
    rifle_fire_cooldown--;
}

if (collect_message_timer > 0)
{
    collect_message_timer--;
}


// =====================================
// RELOAD SYSTEM
// =====================================

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

    if (global.equipped_weapon == "shotgun" && shotgun_current_ammo < shotgun_max_ammo)
    {
        is_reloading = true;
        reload_timer = shotgun_reload_time;
    }

    if (global.equipped_weapon == "rpg" && rpg_current_ammo < rpg_max_ammo)
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
        if (global.equipped_weapon == "pistol") pistol_current_ammo = pistol_max_ammo;
        if (global.equipped_weapon == "rifle") rifle_current_ammo = rifle_max_ammo;
        if (global.equipped_weapon == "shotgun") shotgun_current_ammo = shotgun_max_ammo;
        if (global.equipped_weapon == "rpg") rpg_current_ammo = rpg_max_ammo;

        is_reloading = false;
    }
}


// =====================================
// COLLECT WEAPONS WITH V
// =====================================

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


var shotgun = instance_place(x, y, obj_shotgun_item);

if (shotgun != noone && keyboard_check_pressed(ord("V")))
{
    for (var k = 0; k < 5; k++)
    {
        if (global.weapon_inventory[k] == noone)
        {
            global.weapon_inventory[k] = "shotgun";
            global.selected_weapon_slot = k;
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


var rpg = instance_place(x, y, obj_rpg_item);

if (rpg != noone && keyboard_check_pressed(ord("V")))
{
    for (var r = 0; r < 5; r++)
    {
        if (global.weapon_inventory[r] == noone)
        {
            global.weapon_inventory[r] = "rpg";
            global.selected_weapon_slot = r;
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


// =====================================
// EQUIP WEAPON WITH NUMBER KEYS
// =====================================

if (keyboard_check_pressed(ord("1"))) global.selected_weapon_slot = 0;
if (keyboard_check_pressed(ord("2"))) global.selected_weapon_slot = 1;
if (keyboard_check_pressed(ord("3"))) global.selected_weapon_slot = 2;
if (keyboard_check_pressed(ord("4"))) global.selected_weapon_slot = 3;
if (keyboard_check_pressed(ord("5"))) global.selected_weapon_slot = 4;


// =====================================
// UPDATE EQUIPPED WEAPON
// =====================================

if (global.selected_weapon_slot != -1)
{
    global.equipped_weapon = global.weapon_inventory[global.selected_weapon_slot];
}


// =====================================
// SHOOT WEAPON
// =====================================


// =====================================
// SHOOT WEAPON
// Weapon-specific hand + bullet position
// =====================================

if (global.equipped_weapon != noone && global.equipped_weapon != "sword" && !is_reloading)
{
    var base_y = y - jump_z;

    // Force weapon direction to only left or right
    var dir = 0;

    if (facing_dir == "left")
    {
        dir = 180;
    }
    else
    {
        dir = 0;
    }


    // Default hand position values
    var hand_right_x = 65;
    var hand_right_y = 30;

    var hand_left_x = 4;
    var hand_left_y = 70;

    var barrel_distance = 42;
    var bullet_y_offset = 0;


    // Weapon-specific hand position values
    if (global.equipped_weapon == "pistol")
    {
        hand_right_x = pistol_right_hand_x;
        hand_right_y = pistol_right_hand_y;

        hand_left_x = pistol_left_hand_x;
        hand_left_y = pistol_left_hand_y;

        barrel_distance = pistol_barrel_distance;
        bullet_y_offset = pistol_bullet_y_offset;
    }
    else if (global.equipped_weapon == "rifle")
    {
        hand_right_x = rifle_right_hand_x;
        hand_right_y = rifle_right_hand_y;

        hand_left_x = rifle_left_hand_x;
        hand_left_y = rifle_left_hand_y;

        barrel_distance = rifle_barrel_distance;
        bullet_y_offset = rifle_bullet_y_offset;
    }
    else if (global.equipped_weapon == "shotgun")
    {
        hand_right_x = shotgun_right_hand_x;
        hand_right_y = shotgun_right_hand_y;

        hand_left_x = shotgun_left_hand_x;
        hand_left_y = shotgun_left_hand_y;

        barrel_distance = shotgun_barrel_distance;
        bullet_y_offset = shotgun_bullet_y_offset;
    }
    else if (global.equipped_weapon == "rpg")
    {
        hand_right_x = rpg_right_hand_x;
        hand_right_y = rpg_right_hand_y;

        hand_left_x = rpg_left_hand_x;
        hand_left_y = rpg_left_hand_y;

        barrel_distance = rpg_barrel_distance;
        bullet_y_offset = rpg_bullet_y_offset;
    }


    // Final hand position
    var hand_x = x;
    var hand_y = base_y;

    if (facing_dir == "right")
    {
        hand_x = x + hand_right_x;
        hand_y = base_y + hand_right_y;
    }
    else
    {
        hand_x = x + hand_left_x;
        hand_y = base_y + hand_left_y;
    }


    // Final gun/bullet position
    var gun_distance = 4;

    var gun_x = hand_x + lengthdir_x(gun_distance, dir);
    var gun_y = hand_y;

    var bullet_x = gun_x + lengthdir_x(barrel_distance, dir);
    var bullet_y = gun_y + bullet_y_offset;


    // PISTOL
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

    // RIFLE
    else if (global.equipped_weapon == "rifle")
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

    // SHOTGUN
    else if (global.equipped_weapon == "shotgun")
    {
        if (mouse_check_button_pressed(mb_left) && shotgun_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_shotgun_bullet);

            bullet.direction = dir;
            bullet.speed = 12;

            shotgun_current_ammo--;
        }
    }

    // RPG
    else if (global.equipped_weapon == "rpg")
    {
        if (mouse_check_button_pressed(mb_left) && rpg_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_rpg_bullet);

            bullet.direction = dir;
            bullet.rpg_speed = 12;
            bullet.explosion_sprite = spr_explosion;
            bullet.explosion_target = obj_square;

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
        sword_attack_frame = 0;

        var hit_x = x;
        var hit_y = y;

        if (facing_dir == "left")
        {
            hit_x = x - sword_range;
        }
        else
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
        keyboard_check(ord("A")) ||
        keyboard_check(ord("D"));

    var attack_speed = sword_attack_speed;

    if (is_moving)
    {
        attack_speed *= 0.5;
    }

    sword_attack_frame += attack_speed;

    if (sword_attack_timer <= 0)
    {
        is_sword_attacking = false;
        sword_attack_frame = 0;
    }
}
// =====================================
// HEALTH SYSTEM
// =====================================


// Clamp health
health_current = clamp(
    health_current,
    0,
    health_max
);


// =====================================
// SMOOTH HEALTH BAR
// =====================================

// Health decreases smoothly
if (health_display > health_current)
{
    health_display -= health_display_speed;

    if (health_display < health_current)
    {
        health_display = health_current;
    }
}

// Health increases smoothly
else if (health_display < health_current)
{
    health_display += health_display_speed;

    if (health_display > health_current)
    {
        health_display = health_current;
    }
}


// =====================================
// DAMAGE FLASH TIMER
// =====================================

if (health_damage_flash_timer > 0)
{
    health_damage_flash_timer--;
}


// =====================================
// INVINCIBILITY TIMER
// =====================================

if (invincible)
{
    invincible_timer--;

    if (invincible_timer <= 0)
    {
        invincible = false;
        invincible_timer = 0;
    }
}


// =====================================
// HEALTH REGENERATION
// =====================================

if (health_regen_enabled)
{
    if (health_current < health_max)
    {
        health_regen_timer++;

        if (health_regen_timer >= health_regen_delay)
        {
            health_current += health_regen_amount;

            if (health_current > health_max)
            {
                health_current = health_max;
            }
        }
    }
    else
    {
        health_regen_timer = 0;
    }
}


// =====================================
// CRITICAL HEALTH WARNING
// =====================================

var critical_health =
    health_max * health_critical_percent;

if (health_current <= critical_health)
{
    health_is_critical = true;
}
else
{
    health_is_critical = false;
}


// =====================================
// DEATH CHECK
// =====================================

if (health_current <= 0)
{
    health_current = 0;

    if (!is_dead)
    {
        is_dead = true;
        death_timer = death_delay;
    }
}


// =====================================
// DEATH TIMER / RESPAWN AT LEVEL START
// =====================================

if (is_dead)
{
    if (death_timer > 0)
    {
        death_timer--;
    }
    else
    {
        // Return player to the start of the level
        x = xstart;
        y = ystart;

        // Reset movement
        vsp = 0;
        is_jumping = false;
        is_falling = false;
        is_flying = false;
        is_sprinting = false;

        // Reset health
        health_current = health_max;
        health_display = health_current;

        // Reset death state
        is_dead = false;
        death_timer = 0;

        // Give short invincibility after respawn
        invincible = true;
        invincible_timer = invincible_duration;
    }
}