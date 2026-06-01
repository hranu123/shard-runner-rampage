// =====================================
// AMMO GUI + COLLECT PROMPT + SUCCESS MESSAGE
// =====================================


// =====================================
// AMMO GUI
// Shows only for guns, not sword
// =====================================

if (global.equipped_weapon != noone && global.equipped_weapon != "sword")
{
    var ammo_current = 0;
    var ammo_max = 1;
    var weapon_name = "";

    // Get ammo values for equipped weapon
    if (global.equipped_weapon == "pistol")
    {
        ammo_current = pistol_current_ammo;
        ammo_max = pistol_max_ammo;
        weapon_name = "PISTOL";
    }
    else if (global.equipped_weapon == "rifle")
    {
        ammo_current = rifle_current_ammo;
        ammo_max = rifle_max_ammo;
        weapon_name = "RIFLE";
    }
    else if (global.equipped_weapon == "shotgun")
    {
        ammo_current = shotgun_current_ammo;
        ammo_max = shotgun_max_ammo;
        weapon_name = "SHOTGUN";
    }
	else if (global.equipped_weapon == "rpg")
    {
        ammo_current = rpg_current_ammo;
        ammo_max = rpg_max_ammo;
        weapon_name = "RPG";
    }



    // GUI position
    var ammo_box_w = 220;
    var ammo_box_h = 82;

    var ammo_box_x = display_get_gui_width() - ammo_box_w - 32;
    var ammo_box_y = display_get_gui_height() - ammo_box_h - 32;


    // Background panel
    draw_set_alpha(0.75);
    draw_set_colour(c_black);
    draw_rectangle(
        ammo_box_x,
        ammo_box_y,
        ammo_box_x + ammo_box_w,
        ammo_box_y + ammo_box_h,
        false
    );


    // Border
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_rectangle(
        ammo_box_x,
        ammo_box_y,
        ammo_box_x + ammo_box_w,
        ammo_box_y + ammo_box_h,
        true
    );


    // Weapon name
    draw_set_font(fnt_gun_ammo);
    draw_set_colour(c_white);

    draw_text(
        ammo_box_x + 16,
        ammo_box_y + 12,
        weapon_name
    );


    // Ammo number
    draw_text(
        ammo_box_x + 16,
        ammo_box_y + 36,
        "AMMO: " + string(ammo_current) + " / " + string(ammo_max)
    );


    // Ammo bar background
    draw_set_colour(c_dkgray);

    draw_rectangle(
        ammo_box_x + 16,
        ammo_box_y + 62,
        ammo_box_x + ammo_box_w - 16,
        ammo_box_y + 72,
        false
    );


    // Ammo bar fill
    var ammo_percent = ammo_current / ammo_max;
    ammo_percent = clamp(ammo_percent, 0, 1);

    var bar_w = (ammo_box_w - 32) * ammo_percent;

    draw_set_colour(c_lime);

    draw_rectangle(
        ammo_box_x + 16,
        ammo_box_y + 62,
        ammo_box_x + 16 + bar_w,
        ammo_box_y + 72,
        false
    );


    // Reload warning
    if (ammo_current <= 0)
    {
        draw_set_colour(c_red);

        draw_text(
            ammo_box_x + 110,
            ammo_box_y + 36,
            "R TO RELOAD!"
        );
    }


    // Reset draw settings
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


// =====================================
// PRESS V TO COLLECT WEAPON GUI
// =====================================

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
if (instance_place(x, y, obj_rpg_item) != noone)
{
    touching_weapon = true;
}


if (touching_weapon)
{
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var collect_box_w = 320;
    var collect_box_h = 58;

    var collect_box_x = gui_w / 2 - collect_box_w / 2;
    var collect_box_y = gui_h - 130;


    // Background
    draw_set_alpha(0.75);
    draw_set_colour(c_black);

    draw_roundrect(
        collect_box_x,
        collect_box_y,
        collect_box_x + collect_box_w,
        collect_box_y + collect_box_h,
        false
    );


    // Border
    draw_set_alpha(1);
    draw_set_colour(c_white);

    draw_roundrect(
        collect_box_x,
        collect_box_y,
        collect_box_x + collect_box_w,
        collect_box_y + collect_box_h,
        true
    );


    // Key box
    draw_set_colour(c_yellow);

    draw_roundrect(
        collect_box_x + 18,
        collect_box_y + 12,
        collect_box_x + 58,
        collect_box_y + 46,
        false
    );


    // V text
    draw_set_font(fnt_gun_ammo);
    draw_set_colour(c_black);

    draw_text(
        collect_box_x + 32,
        collect_box_y + 20,
        "V"
    );


    // Prompt text
    draw_set_colour(c_white);

    draw_text(
        collect_box_x + 78,
        collect_box_y + 20,
        "TO COLLECT WEAPON"
    );


    // Reset
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


// =====================================
// COLLECT WEAPON SUCCESS GUI
// =====================================

if (collect_message_timer > 0)
{
    var gui_w_success = display_get_gui_width();

    var success_box_w = 430;
    var success_box_h = 60;

    var success_box_x = gui_w_success / 2 - success_box_w / 2;
    var success_box_y = 90;

    var fade = collect_message_timer / 120;
    fade = clamp(fade, 0, 1);


    // Background box
    draw_set_alpha(fade * 0.85);
    draw_set_colour(c_black);

    draw_roundrect(
        success_box_x,
        success_box_y,
        success_box_x + success_box_w,
        success_box_y + success_box_h,
        false
    );


    // Green border
    draw_set_alpha(fade);
    draw_set_colour(c_lime);

    draw_roundrect(
        success_box_x,
        success_box_y,
        success_box_x + success_box_w,
        success_box_y + success_box_h,
        true
    );


    // Message text
    draw_set_font(fnt_gun_ammo);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(
        gui_w_success / 2,
        success_box_y + success_box_h / 2,
        "COLLECTED WEAPON SUCCESSFULLY!"
    );


    // Reset draw settings
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}