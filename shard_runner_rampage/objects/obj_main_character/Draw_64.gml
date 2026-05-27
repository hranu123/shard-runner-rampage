// =====================================
// AMMO GUI
// =====================================

// Only show ammo if weapon is equipped
if (global.equipped_weapon != noone)
{
    var ammo_current = 0;
    var ammo_max = 0;
    var weapon_name = "";

    // Get ammo values for equipped weapon
    if (global.equipped_weapon == "pistol")
    {
        ammo_current = pistol_current_ammo;
        ammo_max = pistol_max_ammo;
        weapon_name = "PISTOL";
    }

    if (global.equipped_weapon == "rifle")
    {
        ammo_current = rifle_current_ammo;
        ammo_max = rifle_max_ammo;
        weapon_name = "RIFLE";
    } 
	if (global.equipped_weapon == "shotgun")
    {
        ammo_current = shotgun_current_ammo;
        ammo_max = shotgun_max_ammo;
        weapon_name = "SHOTGUN";
    }

    // GUI position
    var box_w = 220;
    var box_h = 82;
    var box_x = display_get_gui_width() - box_w - 32;
    var box_y = display_get_gui_height() - box_h - 32;

    // Background panel
    draw_set_alpha(0.75);
    draw_set_colour(c_black);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

    // Border
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

    // Weapon name
    draw_set_colour(c_white);
    draw_text(box_x + 16, box_y + 12, weapon_name);

    // Ammo number
    draw_text(
        box_x + 16,
        box_y + 36,
        "AMMO: " + string(ammo_current) + " / " + string(ammo_max)
    );

    // Ammo bar background
    draw_set_colour(c_dkgray);
    draw_rectangle(box_x + 16, box_y + 62, box_x + box_w - 16, box_y + 72, false);

    // Ammo bar fill
    var ammo_percent = ammo_current / ammo_max;
    var bar_w = (box_w - 32) * ammo_percent;

    draw_set_colour(c_lime);
    draw_rectangle(box_x + 16, box_y + 62, box_x + 16 + bar_w, box_y + 72, false);

    // Reload warning
    if (ammo_current <= 0)
    {
		draw_set_colour(c_red);
        draw_text(box_x + 125, box_y + 36, "PRESS R TO RELOAD!");
    }

    // Reset drawing
    draw_set_alpha(1);
    draw_set_colour(c_white);
}

// Press V to collect weapon gui
var touching_weapon = false;

if (instance_place(x, y, obj_pistol_item) != noone)
{
    touching_weapon = true;
}

if (instance_place(x, y, obj_rifle_item) != noone)
{
    touching_weapon = true;
}
if (instance_place(x, y, obj_shotgun_item) != noone)
{
    touching_weapon = true;
}

if (touching_weapon)
{
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var box_w = 320;
    var box_h = 58;

    var box_x = gui_w / 2 - box_w / 2;
    var box_y = gui_h - 130;

    // Background
    draw_set_alpha(0.75);
    draw_set_colour(c_black);
    draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, false);

    // Border
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, true);

    // Key box
    draw_set_colour(c_yellow);
    draw_roundrect(box_x + 18, box_y + 12, box_x + 58, box_y + 46, false);

    draw_set_colour(c_black);
    draw_text(box_x + 32, box_y + 20, "V");

    // Text
    draw_set_colour(c_white);
    draw_text(box_x + 78, box_y + 20, "TO COLLECT WEAPON");

    // Reset
    draw_set_alpha(1);
    draw_set_colour(c_white);
}
// =====================================
// COLLECT WEAPON SUCCESS GUI
// =====================================

if (collect_message_timer > 0)
{
    var gui_w = display_get_gui_width();

    var box_w = 430;
    var box_h = 60;

    var box_x = gui_w / 2 - box_w / 2;
    var box_y = 90;

    var fade = collect_message_timer / 120;

    // Background box
    draw_set_alpha(fade * 0.85);
    draw_set_colour(c_black);
    draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, false);

    // Green border
    draw_set_alpha(fade);
    draw_set_colour(c_lime);
    draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, true);

    // Message text
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(
        gui_w / 2,
        box_y + box_h / 2,
        "COLLECTED WEAPON SUCCESSFULLY!"
    );

    // Reset draw settings
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
