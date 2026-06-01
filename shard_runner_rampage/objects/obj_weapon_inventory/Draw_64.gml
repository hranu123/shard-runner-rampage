// Safety check: make sure inventory has 5 slots
if (!variable_global_exists("weapon_inventory") || array_length(global.weapon_inventory) < 5)
{
    global.weapon_inventory = [noone, noone, noone, noone, noone];

    // Sword starts in slot 1
    global.weapon_inventory[0] = "sword";

    global.selected_weapon_slot = 0;
    global.equipped_weapon = "sword";
}

var slot_size = 64;
var start_x = 40;
var start_y = 40;
var gap = 10;

for (var i = 0; i < 5; i++)
{
    var slot_x = start_x + i * (slot_size + gap);
    var slot_y = start_y;

    draw_set_colour(c_white);
    draw_rectangle(slot_x, slot_y, slot_x + slot_size, slot_y + slot_size, false);

    if (global.selected_weapon_slot == i)
    {
        draw_set_colour(c_yellow);
        draw_rectangle(slot_x - 3, slot_y - 3, slot_x + slot_size + 3, slot_y + slot_size + 3, false);
        draw_set_colour(c_white);
    }

    var weapon_sprite = noone;

    if (global.weapon_inventory[i] == "sword") weapon_sprite = spr_sword;
    if (global.weapon_inventory[i] == "pistol") weapon_sprite = spr_pistol;
    if (global.weapon_inventory[i] == "rifle") weapon_sprite = spr_rifle;
    if (global.weapon_inventory[i] == "shotgun") weapon_sprite = spr_shotgun;
	if (global.weapon_inventory[i] == "rpg") weapon_sprite = spr_rpg;

    if (weapon_sprite != noone)
    {
        draw_sprite_ext(
            weapon_sprite,
            0,
            slot_x + slot_size / 2,
            slot_y + slot_size / 2,
            0.5,
            0.5,
            0,
            c_white,
            1
        );
    }

    draw_set_colour(c_white);
    draw_text(slot_x + 24, slot_y + 70, string(i + 1));
}