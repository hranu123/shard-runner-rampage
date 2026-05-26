// =====================================
// INVENTORY + WEAPON SYSTEM
// PISTOL + RIFLE + AMMO VERSION
// =====================================


// =====================================
// SAFETY CHECK
// Creates inventory if missing
// =====================================
if (!variable_global_exists("weapon_inventory"))
{
    global.weapon_inventory = [noone, noone, noone, noone, noone];
    global.selected_weapon_slot = -1;
    global.equipped_weapon = noone;
}


// =====================================
// CREATE PLAYER WEAPON VARIABLES IF MISSING
// =====================================
if (!variable_instance_exists(id, "rifle_fire_cooldown"))
{
    rifle_fire_cooldown = 0;
}

if (!variable_instance_exists(id, "pistol_current_ammo"))
{
    pistol_max_ammo = 8;
    pistol_current_ammo = pistol_max_ammo;

    rifle_max_ammo = 25;
    rifle_current_ammo = rifle_max_ammo;

    is_reloading = false;
    reload_timer = 0;
    reload_time = 60;
}


// =====================================
// COUNT DOWN RIFLE FIRE COOLDOWN
// =====================================
if (rifle_fire_cooldown > 0)
{
    rifle_fire_cooldown -= 1;
}


// =====================================
// RELOAD SYSTEM
// Press R to reload equipped weapon
// =====================================
if (keyboard_check_pressed(ord("R")) && !is_reloading)
{
    if (global.equipped_weapon == "pistol" && pistol_current_ammo < pistol_max_ammo)
    {
        is_reloading = true;
        reload_timer = reload_time;
    }

    if (global.equipped_weapon == "rifle" && rifle_current_ammo < rifle_max_ammo)
    {
        is_reloading = true;
        reload_timer = reload_time;
    }
}


// Finish reload after timer reaches 0
if (is_reloading)
{
    reload_timer -= 1;

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

        is_reloading = false;
    }
}


// =====================================
// COLLECT PISTOL
// =====================================
var pistol = instance_place(x, y, obj_pistol_item);

if (pistol != noone)
{
    for (var i = 0; i < 5; i++)
    {
        if (global.weapon_inventory[i] == noone)
        {
            global.weapon_inventory[i] = "pistol";
            global.selected_weapon_slot = i;
            global.equipped_weapon = "pistol";

            with (pistol)
            {
                instance_destroy();
            }

            break;
        }
    }
}


// =====================================
// COLLECT RIFLE
// =====================================
var rifle = instance_place(x, y, obj_rifle_item);

if (rifle != noone)
{
    for (var j = 0; j < 5; j++)
    {
        if (global.weapon_inventory[j] == noone)
        {
            global.weapon_inventory[j] = "rifle";
            global.selected_weapon_slot = j;
            global.equipped_weapon = "rifle";

            with (rifle)
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
if (global.equipped_weapon != noone && !is_reloading)
{
    var dir = point_direction(x, y, mouse_x, mouse_y);

    var bullet_x = x + lengthdir_x(24, dir);
    var bullet_y = y + lengthdir_y(24, dir);


    // =================================
    // PISTOL
    // Shoots once per click
    // Uses 1 bullet each shot
    // =================================
    if (global.equipped_weapon == "pistol")
    {
        if (mouse_check_button_pressed(mb_left) && pistol_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_bullet);

            bullet.direction = dir;
            bullet.speed = 12;

            pistol_current_ammo -= 1;
        }
    }


    // =================================
    // RIFLE
    // Hold left mouse to shoot
    // Uses 1 bullet each shot
    // =================================
    if (global.equipped_weapon == "rifle")
    {
        if (mouse_check_button(mb_left) && rifle_fire_cooldown <= 0 && rifle_current_ammo > 0)
        {
            var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_bullet);

            bullet.direction = dir;
            bullet.speed = 18;

            rifle_current_ammo -= 1;

            // Lower number = faster rifle shooting
            rifle_fire_cooldown = 6;
        }
    }
}