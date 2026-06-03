// MOVEMENT VARIABLES
var_walk_speed = 3;

var_main_sprint = 7;

var_main_speed = var_walk_speed;

var_walk_animation = 2.5;

var_sprint_animation = 5;

var_main_animation_speed = var_walk_animation;

facing_dir = "down";
// WEAPON MECHANICS
// Rifle automatic fire cooldown
rifle_fire_cooldown = 0;
// Pistol ammo
pistol_max_ammo = 12;
pistol_current_ammo = pistol_max_ammo;
// Rifle ammo
rifle_max_ammo = 30;
rifle_current_ammo = rifle_max_ammo;
// Shotgun ammo
shotgun_max_ammo = 8;
shotgun_current_ammo = shotgun_max_ammo;
// Rpg ammo
rpg_max_ammo = 5
rpg_current_ammo = rpg_max_ammo
// Reload system
is_reloading = false;
reload_timer = 0;
pistol_reload_time = 30;
rifle_reload_time = 60;
shotgun_reload_time = 90;
rpg_reload_time = 120
// Weapon collect message
collect_message_timer = 0;
// Sword is always available in inventory
global.weapon_inventory[0] = "sword";
global.selected_weapon_slot = 0;
global.equipped_weapon = "sword";

// =====================================
// SWORD SYSTEM
// =====================================

// Sword starts in inventory slot 1
if (!variable_global_exists("weapon_inventory"))
{
    global.weapon_inventory = [noone, noone, noone, noone, noone];
}

global.weapon_inventory[0] = "sword";
global.selected_weapon_slot = 0;
global.equipped_weapon = "sword";

// Sword attack settings
is_sword_attacking = false;
sword_attack_timer = 0;
sword_attack_duration = 20;

sword_attack_frame = 0;
sword_attack_speed = 0.35;

sword_damage = 1;
sword_range = 36;
// HEALTH
health_max = 100;
health_current = health_max;


// STAMINA
stamina_max = 200;
stamina_current = stamina_max;
stamina_recover_speed = 0.5;


// SPRINT
is_sprinting = false;

sprint_stamina_drain = 1;
sprint_min_stamina = 5;

sprint_cooldown = 0;
sprint_cooldown_time = 90;

sprint_locked = false;
sprint_resume_stamina = 25;

// JUMP
is_jumping = false;

jump_z = 0;
jump_timer = 0;
jump_duration = 24;
jump_height = 50;

jump_stamina_cost = 20;
jump_cooldown = 0;
jump_cooldown_time = 45;


// FLY
is_flying = false;

space_hold_timer = 0;
fly_hold_delay = 8;

fly_height = 34;
fly_speed = 5;

fly_time_max = 180;
fly_timer = 0;

fly_min_stamina = 10;
fly_stamina_drain = 0.8;

fly_cooldown = 0;
fly_cooldown_time = 90;