// =====================================
// ATTACK TIMER
// =====================================

if (attack_sprite_timer > 0)
{
    attack_sprite_timer--;
}
else
{
    is_attacking_player = false;
}
// =====================================
// ENEMY HEALTH 
// =====================================

enemy_health_current = clamp(enemy_health_current, 0, enemy_health_max);


// Smooth delayed health bar
if (enemy_health_display > enemy_health_current)
{
    enemy_health_display -= enemy_health_display_speed;

    if (enemy_health_display < enemy_health_current)
    {
        enemy_health_display = enemy_health_current;
    }
}
else
{
    enemy_health_display = enemy_health_current;
}


// Damage flash timer
if (enemy_damage_flash_timer > 0)
{
    enemy_damage_flash_timer--;
}


// =====================================
// RIFLE BULLET DAMAGE
// =====================================

var hit_bullet = instance_place(x, y, obj_rifle_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_rifle_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}

// =====================================
// PISTOL BULLET DAMAGE
// =====================================
var hit_bullet = instance_place(x, y, obj_pistol_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_pistol_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}
// =====================================
// SHOTGUN BULLET DAMAGE
// =====================================
var hit_bullet = instance_place(x, y, obj_shotgun_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_shotgun_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}
// =====================================
// ENEMY DEATH
// =====================================

if (enemy_health_current <= 0 && !enemy_is_dead)
{
    enemy_health_current = 0;
    enemy_is_dead = true;

    global.enemy_eliminated_message_text = "ENEMY ELIMINATED";
    global.enemy_eliminated_message_timer = 90;
    global.enemy_eliminated_message_duration = 90;

    instance_destroy();
}
// =====================================
// FIND PLAYER
// =====================================

var player = instance_nearest(x, y, obj_main_character);


// =====================================
// DETECTION
// =====================================

if (player != noone)
{
    var dist_to_player = point_distance(x, y, player.x, player.y);

    if (
        dist_to_player <= guard_walk_detect_range ||
        (global.player_is_sprinting == true && dist_to_player <= guard_sprint_detect_range)
    )
    {
        global.has_discovered_player2 = true;
    }
}

is_chasing = global.has_discovered_player2;


// =====================================
// RESET MOVEMENT
// =====================================

hsp = 0;
vsp = 0;


// =====================================
// CHASE PLAYER
// Enemy follows behind player and avoids moving in front
// =====================================

if (is_chasing && player != noone)
{
    var follow_distance_x = 180;
    var follow_distance_y = 120;
    var stop_distance = 15;

    var target_x = player.x;
    var target_y = player.y;

    // Behind target based on player's facing direction
    if (player.facing_dir == "right")
    {
        target_x = player.x - follow_distance_x;
        target_y = player.y;
    }
    else if (player.facing_dir == "left")
    {
        target_x = player.x + follow_distance_x;
        target_y = player.y;
    }
    else if (player.facing_dir == "up")
    {
        target_x = player.x;
        target_y = player.y + follow_distance_y;
    }
    else if (player.facing_dir == "down")
    {
        target_x = player.x;
        target_y = player.y - follow_distance_y;
    }

    // Extra correction for left-facing player
    // Prevents enemy from slipping to the front-left side
    if (player.facing_dir == "left")
    {
        if (x < player.x)
        {
            target_x = player.x + follow_distance_x;
        }
    }

    var dist_to_target = point_distance(x, y, target_x, target_y);

    // Face the player
    var dx = player.x - x;
    var dy = player.y - y;

    if (abs(dx) > abs(dy))
    {
        if (dx < 0)
        {
            facing_dir = "left";
        }
        else
        {
            facing_dir = "right";
        }
    }
    else
    {
        if (dy < 0)
        {
            facing_dir = "up";
        }
        else
        {
            facing_dir = "down";
        }
    }

    // Move toward behind target
    if (dist_to_target > stop_distance)
    {
        var move_dir = point_direction(x, y, target_x, target_y);

        hsp = lengthdir_x(guard_fly_speed, move_dir);
        vsp = lengthdir_y(guard_fly_speed, move_dir);
    }
    else
    {
        hsp = 0;
        vsp = 0;
    }
}

// =====================================
// PATROL RANDOMLY UNTIL DETECTION
// =====================================

else
{
    hsp = lengthdir_x(guard_patrol_speed, guard_patrol_direction);
    vsp = lengthdir_y(guard_patrol_speed, guard_patrol_direction);

    if (guard_turn_cooldown > 0)
    {
        guard_turn_cooldown--;
    }

    if (place_meeting(x, y, obj_knight_blocker) && guard_turn_cooldown <= 0)
    {
        x -= lengthdir_x(8, guard_patrol_direction);
        y -= lengthdir_y(8, guard_patrol_direction);

        guard_patrol_direction = choose(0, 90, 180, 270);
        guard_turn_cooldown = 30;
    }

    if (guard_patrol_direction == 0)
    {
        facing_dir = "right";
    }
    else if (guard_patrol_direction == 180)
    {
        facing_dir = "left";
    }
    else if (guard_patrol_direction == 90)
    {
        facing_dir = "up";
    }
    else if (guard_patrol_direction == 270)
    {
        facing_dir = "down";
    }
}


// =====================================
// APPLY MOVEMENT
// =====================================

x += hsp;
y += vsp;
// =====================================
// ENEMY CONTACT DAMAGE - DISTANCE BASED
// Works even when enemy stands behind player
// =====================================

if (enemy_damage_cooldown > 0)
{
    enemy_damage_cooldown--;
}

if (player != noone && !player.is_dead)
{
    var attack_dist = point_distance(x, y, player.x, player.y);

    if (attack_dist <= 200)
    {
        if (enemy_damage_cooldown <= 0)
        {
            global.health_current -= enemy_contact_damage;
            global.health_current = clamp(global.health_current, 0, global.health_max);

            player.health_damage_flash_timer = player.health_damage_flash_duration;
            player.health_regen_timer = 0;

            enemy_damage_cooldown = enemy_damage_cooldown_max;

            is_attacking_player = true;
            attack_sprite_timer = attack_sprite_duration;
            image_index = 0;
        }
    }
}

// =====================================
// SPRITE SYSTEM - FLY SPRITES ONLY
// =====================================
// =====================================
// SPRITE SYSTEM
// =====================================

if (is_attacking_player)
{
    if (facing_dir == "up")
    {
        sprite_index = spr_dad_attack_up;
    }
    else if (facing_dir == "down")
    {
        sprite_index = spr_dad_attack_down;
    }
    else if (facing_dir == "left")
    {
        sprite_index = spr_dad_attack_left;
    }
    else
    {
        sprite_index = spr_dad_attack_right;
    }

    image_speed = guard_attack_animation_speed;
}
else
{
    if (facing_dir == "up")
    {
        sprite_index = spr_dad_fly_up;
    }
    else if (facing_dir == "down")
    {
        sprite_index = spr_dad_fly_down;
    }
    else if (facing_dir == "left")
    {
        sprite_index = spr_dad_fly_left;
    }
    else
    {
        sprite_index = spr_dad_fly_right;
    }

    image_speed = guard_fly_animation_speed;
}
