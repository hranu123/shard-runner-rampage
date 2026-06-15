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
// DETECTION / GIVE UP CHASE
// =====================================

if (player != noone)
{
    var dist_to_player = point_distance(x, y, player.x, player.y);

    // If player gets too far, stop chasing and return to spawn
    if (is_chasing && dist_to_player > guard_return_distance)
    {
        global.has_discovered_player5 = false;
        is_chasing = false;
        is_returning_to_spawn = true;
        is_attacking_player = false;
        attack_sprite_timer = 0;
    }

    // Detect player only if not returning
    if (!is_returning_to_spawn)
    {
        if (
            dist_to_player <= guard_walk_detect_range ||
            (global.player_is_sprinting == true && dist_to_player <= guard_sprint_detect_range)
        )
        {
            global.has_discovered_player5 = true;
            is_chasing = true;
        }
    }
}

is_chasing = global.has_discovered_player5;


// =====================================
// RESET MOVEMENT
// =====================================

hsp = 0;
vsp = 0;


// =====================================
// RETURN TO SPAWN
// =====================================

if (is_returning_to_spawn)
{
    var dist_to_spawn = point_distance(x, y, spawn_x, spawn_y);

    if (dist_to_spawn > guard_return_stop_distance)
    {
        var return_dir = point_direction(x, y, spawn_x, spawn_y);

        hsp = lengthdir_x(guard_fly_speed, return_dir);
        vsp = lengthdir_y(guard_fly_speed, return_dir);

        if (abs(spawn_x - x) > abs(spawn_y - y))
        {
            if (spawn_x < x) facing_dir = "left";
            else facing_dir = "right";
        }
        else
        {
            if (spawn_y < y) facing_dir = "up";
            else facing_dir = "down";
        }
    }
    else
    {
        x = spawn_x;
        y = spawn_y;

        hsp = 0;
        vsp = 0;

        is_returning_to_spawn = false;
        is_chasing = false;
        global.has_discovered_player5 = false;

        guard_patrol_direction = choose(0, 90, 180, 270);
    }
}


// =====================================
// CHASE PLAYER
// Enemy follows behind player
// =====================================

else if (is_chasing && player != noone)
{
    var follow_distance_x = 180;
    var follow_distance_y = 120;
    var stop_distance = 15;

    var target_x = player.x;
    var target_y = player.y;

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

    var dist_to_target = point_distance(x, y, target_x, target_y);

    var dx = player.x - x;
    var dy = player.y - y;

    if (abs(dx) > abs(dy))
    {
        if (dx < 0) facing_dir = "left";
        else facing_dir = "right";
    }
    else
    {
        if (dy < 0) facing_dir = "up";
        else facing_dir = "down";
    }

    if (dist_to_target > stop_distance)
    {
        var move_dir = point_direction(x, y, target_x, target_y);

        hsp = lengthdir_x(guard_fly_speed, move_dir);
        vsp = lengthdir_y(guard_fly_speed, move_dir);
    }
}

// =====================================
// PATROL RANDOMLY UNTIL DETECTION
// Smooth blocker handling
// =====================================

else
{
    if (guard_turn_cooldown > 0)
    {
        guard_turn_cooldown--;
    }

    // Predict next position before moving
    var move_dir = guard_patrol_direction;

    var next_x = x + lengthdir_x(guard_patrol_speed, move_dir);
    var next_y = y + lengthdir_y(guard_patrol_speed, move_dir);

    // If next position hits blocker, turn before getting stuck
    if (place_meeting(next_x, next_y, obj_knight_blocker))
    {
        if (guard_turn_cooldown <= 0)
        {
            hsp = 0;
            vsp = 0;

            // Move slightly away from blocker
            x -= lengthdir_x(4, move_dir);
            y -= lengthdir_y(4, move_dir);

            // Choose a new direction that is not the same direction
            var new_dir = choose(0, 90, 180, 270);

            repeat (8)
            {
                if (new_dir != guard_patrol_direction)
                {
                    break;
                }

                new_dir = choose(0, 90, 180, 270);
            }

            guard_patrol_direction = new_dir;
            guard_turn_cooldown = 20;
        }
    }
    else
    {
        hsp = lengthdir_x(guard_patrol_speed, guard_patrol_direction);
        vsp = lengthdir_y(guard_patrol_speed, guard_patrol_direction);
    }


    // =====================================
    // FACE PATROL DIRECTION
    // =====================================

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
        sprite_index = spr_mom_attack_up;
    }
    else if (facing_dir == "down")
    {
        sprite_index = spr_mom_attack_down;
    }
    else if (facing_dir == "left")
    {
        sprite_index = spr_mom_attack_left;
    }
    else
    {
        sprite_index = spr_mom_attack_right;
    }

    image_speed = guard_attack_animation_speed;
}
else
{
    if (facing_dir == "up")
    {
        sprite_index = spr_mom_fly_up;
    }
    else if (facing_dir == "down")
    {
        sprite_index = spr_mom_fly_down;
    }
    else if (facing_dir == "left")
    {
        sprite_index = spr_mom_fly_left;
    }
    else
    {
        sprite_index = spr_mom_fly_right;
    }

    image_speed = guard_fly_animation_speed;
}
