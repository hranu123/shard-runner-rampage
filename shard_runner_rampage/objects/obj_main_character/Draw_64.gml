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
        draw_text(box_x + 125, box_y + 36, "RELOAD!");
    }

    // Reset drawing
    draw_set_alpha(1);
    draw_set_colour(c_white);
}


