// MOVEMENT VARIABLES
var_walk_speed = 3;

var_main_sprint = 7;

var_main_speed = var_walk_speed;

var_walk_animation = 2.5;

var_sprint_animation = 2.5;

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

sword_damage = 10;
sword_range = 36;
// =====================================
// HEALTH SYSTEM
// =====================================

// Main health values
global.health_max = 100;
global.health_current = global.health_max;


// =====================================
// DAMAGE / HIT FEEDBACK
// =====================================

health_damage_flash_timer = 0;
health_damage_flash_duration = 15;


// =====================================
// INVINCIBILITY FRAMES
// Prevents taking damage every single frame
// =====================================

invincible = false;
invincible_timer = 0;
invincible_duration = 30;


// =====================================
// HEALTH REGENERATION
// =====================================

health_regen_enabled = false;
health_regen_delay = 180;
health_regen_timer = 0;
health_regen_amount = 0.25;


// =====================================
// HEALTH BAR SETTINGS
// =====================================

health_bar_width = 420;
health_bar_height = 36;

health_display = global.health_current;
health_display_speed = 0.5;


// =====================================
// CRITICAL HEALTH WARNING
// =====================================

health_critical_percent = 0.25;
health_is_critical = false;


// =====================================
// DEATH SYSTEM
// =====================================

is_dead = false;
death_timer = 0;
death_delay = 120;

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

jump_stamina_cost = 25;
jump_cooldown = 0;
jump_cooldown_time = 45;


// FLY
is_flying = false;

space_hold_timer = 0;
fly_hold_delay = 30;

fly_lift_speed = 30;
fly_lift_time = 5;
fly_lift_timer = 0;
is_fly_lifting = false;
fly_speed = 5;

fly_time_max = 180;
fly_timer = 0;

fly_min_stamina = 10;
fly_stamina_drain = 0.8;

fly_cooldown = 0;
fly_cooldown_time = 90;

fly_animation_speed = 0.05;
fly_anim_frame = 0;
last_fly_sprite = noone;
// =====================================
// GRAVITY / PLATFORM SYSTEM
// =====================================

vsp = 0;

gravity_force = 0.6;
jump_force = -10;
max_fall_speed = 14;

is_grounded = false;
is_falling = false;

mask_index = spr_main_character_right_walk;

// =====================================
// WEAPON HAND POSITION VARIABLES
// Customize each weapon separately
// =====================================

// PISTOL
pistol_right_hand_x = 65;
pistol_right_hand_y = 40;
pistol_left_hand_x = 4;
pistol_left_hand_y = 60;
pistol_barrel_distance = 12;
pistol_bullet_y_offset = 0;

// RIFLE
rifle_right_hand_x = 65;
rifle_right_hand_y = 25;
rifle_left_hand_x = 4;
rifle_left_hand_y = 45;
rifle_barrel_distance = 48;
rifle_bullet_y_offset = 0;

// SHOTGUN
shotgun_right_hand_x = 65;
shotgun_right_hand_y = 30;
shotgun_left_hand_x = 4;
shotgun_left_hand_y = 50;
shotgun_barrel_distance = 48;
shotgun_bullet_y_offset = 0;

// RPG
rpg_right_hand_x = 70;
rpg_right_hand_y = 28;
rpg_left_hand_x = -8;
rpg_left_hand_y = 70;
rpg_barrel_distance = 50;
rpg_bullet_y_offset = -6;
