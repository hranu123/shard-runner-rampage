//ENEMY SPAWN POINT
spawn_x = x;
spawn_y = y;


// =====================================
// ENEMY HEALTH SYSTEM
// =====================================
enemy_health_max = 100;
enemy_health_current = enemy_health_max;

// Smooth delayed health bar
enemy_health_display = enemy_health_current;
enemy_health_display_speed = 1.2;

// Damage feedback
enemy_damage_flash_timer = 0;
enemy_damage_flash_duration = 10;

// Bullet damage
enemy_rifle_damage = 20;
enemy_pistol_damage = 10;
enemy_shotgun_damage = 50;
// Health bar settings
enemy_health_bar_width = 70;
enemy_health_bar_height = 8;
enemy_health_bar_y_offset = -45;

// Death
enemy_is_dead = false;
// Elimination message
global.enemy_eliminated_message_text = "";
global.enemy_eliminated_message_timer = 0;
global.enemy_eliminated_message_duration = 90;
// =====================================
// GUARD
// =====================================

guard_patrol_speed = 3.5;
guard_fly_speed = 7;

guard_walk_detect_range = 350;
guard_sprint_detect_range = 650;

guard_patrol_direction = choose(-1, 1); // -1 left, 1 right


guard_fly_animation_speed = 1;

hsp = 0;
vsp = 0;

gravity_force = 0.4;
max_fall_speed = 8;

is_grounded = false;
is_falling = false;
is_flying = false;
is_chasing = false;

facing_dir = "right";

global.has_discovered_player3 = false;
guard_turn_cooldown = 0;

// Attack system
is_attacking_player = false;
attack_sprite_timer = 0;
attack_sprite_duration = 20;
guard_attack_animation_speed = 2;
enemy_damage_cooldown = 0;
enemy_damage_cooldown_max = 35;
enemy_contact_damage = 10;

// =====================================
// CHASE RETURN SYSTEM
// =====================================

guard_return_distance = 900;      // Distance where guard gives up chasing
guard_return_stop_distance = 8;   // How close to spawn before stopping
is_returning_to_spawn = false;