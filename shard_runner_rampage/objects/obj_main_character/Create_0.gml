var_walk_speed = 3;

var_main_sprint = 7;

var_main_speed = var_walk_speed;

var_walk_animation = 2.5;

var_sprint_animation = 5;

var_main_animation_speed = var_walk_animation;
// =====================================
// JUMP / FLY VARIABLES
// =====================================

is_jumping = false;
is_flying = false;

jump_z = 0;
jump_timer = 0;
jump_duration = 24;
jump_height = 100

space_hold_timer = 0;
fly_hold_delay = 15

fly_height = 35;
fly_speed = 5;

facing_dir = "down";

global.player_sprinting = false;
// Rifle automatic fire cooldown
rifle_fire_cooldown = 0;
// Pistol ammo
pistol_max_ammo = 12;
pistol_current_ammo = pistol_max_ammo;

// Rifle ammo
rifle_max_ammo = 30;
rifle_current_ammo = rifle_max_ammo;
// Shotgun ammo
shotgun_max_ammo = 5
shotgun_current_ammo = shotgun_max_ammo
// Reload system
is_reloading = false;
reload_timer = 0;
pistol_reload_time = 30;
rifle_reload_time = 60;
shotgun_reload_time = 90;
// Weapon collect message
collect_message_timer = 0;// MOVEMENT VARIABLES
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



