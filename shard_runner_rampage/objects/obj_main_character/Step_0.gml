// COLLECT PISTOL
var pistol = instance_place(x, y, obj_pistol_item);

if (pistol != noone)
{
    for (var i = 0; i < 5; i++)
    {
        if (global.weapon_inventory[i] == noone)
        {
            // Store pistol sprite in inventory
            global.weapon_inventory[i] = spr_pistol;

            // Automatically equip the pistol after collecting it
            global.selected_weapon_slot = i;
            global.equipped_weapon = global.weapon_inventory[i];

            with (pistol)
            {
                instance_destroy();
            }

            break;
        }
    }
}


// PRESS 1-5 TO EQUIP
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


// SHOOT
if (global.equipped_weapon != noone)
{
    if (mouse_check_button_pressed(mb_left))
    {
        var dir = point_direction(x, y, mouse_x, mouse_y);

        var bullet_x = x + lengthdir_x(24, dir);
        var bullet_y = y + lengthdir_y(24, dir);

        var bullet = instance_create_layer(bullet_x, bullet_y, layer, obj_bullet);

        bullet.direction = dir;
        bullet.speed = 12;
    }
}