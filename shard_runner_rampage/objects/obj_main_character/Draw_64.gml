// =====================================
// STAMINA GUI
// =====================================

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var box_w = 360;
var box_h = 86;


// =====================================
// CENTER BOTTOM POSITION
// =====================================

var box_x = gui_w / 2 - box_w / 2;
var box_y = gui_h - box_h - 10;

var bar_x = box_x + 24;
var bar_y = box_y + 46;

var bar_w = 312;
var bar_h = 18;


// =====================================
// BACKGROUND SHADOW
// =====================================

draw_set_alpha(0.35);
draw_set_colour(c_black);

draw_roundrect(box_x + 5, box_y + 5, box_x + box_w + 5, box_y + box_h + 5, false);


// =====================================
// BACKGROUND PANEL
// =====================================

draw_set_alpha(0.88);
draw_set_colour(c_black);

draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, false);


// =====================================
// BORDER
// =====================================

draw_set_alpha(1);
draw_set_colour(c_white);

draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, true);


// =====================================
// TITLE
// =====================================

draw_set_colour(c_white);
draw_text(box_x + 24, box_y + 14, "STAMINA");


// =====================================
// STAMINA NUMBER
// =====================================

draw_text(
    box_x + 250,
    box_y + 14,
    string(floor(stamina_current)) + " / " + string(stamina_max)
);


// =====================================
// BAR BACKGROUND
// =====================================

draw_set_colour(c_dkgray);

draw_roundrect(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);


// =====================================
// STAMINA BAR FILL
// =====================================

var stamina_percent = stamina_current / stamina_max;
stamina_percent = clamp(stamina_percent, 0, 1);

var fill_w = bar_w * stamina_percent;

if (stamina_percent > 0.5)
{
    draw_set_colour(c_lime);
}
else if (stamina_percent > 0.25)
{
    draw_set_colour(c_yellow);
}
else
{
    draw_set_colour(c_red);
}

draw_roundrect(bar_x, bar_y, bar_x + fill_w, bar_y + bar_h, false);


// =====================================
// INNER BAR HIGHLIGHT
// =====================================

draw_set_alpha(0.35);
draw_set_colour(c_white);

draw_rectangle(bar_x + 3, bar_y + 3, bar_x + fill_w - 3, bar_y + 7, false);

draw_set_alpha(1);


// =====================================
// BAR BORDER
// =====================================

draw_set_colour(c_white);
draw_roundrect(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);


// =====================================
// STATUS TEXT
// =====================================

if (stamina_current <= sprint_min_stamina)
{
     draw_set_font(fnt_text);
	draw_set_colour(c_red);
    draw_text(box_x + 24, box_y + 66, "LOW STAMINA");
}
else if (sprint_locked)
{
     draw_set_font(fnt_text);
	draw_set_colour(c_yellow);
    draw_text(box_x + 24, box_y + 66, "RECOVERING");
}
else if (global.player_is_sprinting)
{
     draw_set_font(fnt_text);
	draw_set_colour(c_lime);
    draw_text(box_x + 24, box_y + 66, "SPRINTING");
}
else if (is_flying)
{
     draw_set_font(fnt_text);
	draw_set_colour(c_aqua);
    draw_text(box_x + 24, box_y + 66, "FLYING");
}


// =====================================
// RESET DRAW SETTINGS
// =====================================

draw_set_alpha(1);
draw_set_colour(c_white);
 draw_set_font(fnt_text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
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
    draw_set_font(fnt_text);
    draw_set_colour(c_white);

    draw_text(
        ammo_box_x + 12,
        ammo_box_y + 12,
        weapon_name
    );


    // Ammo number
    draw_set_font(fnt_text);
	draw_text(
        ammo_box_x + 12,
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
		 draw_set_font(fnt_text);
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
    var collect_box_y = gui_h - 170;


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
     draw_set_font(fnt_text);
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
    draw_set_font(fnt_text);
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
// =====================================
// HEALTH BAR 
// =====================================


// =====================================
// GUI SIZE
// =====================================

var gui_w = display_get_gui_width();


// =====================================
// BAR SETTINGS
// =====================================

var bar_w = health_bar_width;
var bar_h = health_bar_height;

var bar_x = (gui_w * 0.5) - (bar_w * 0.5);
var bar_y = 25;


// =====================================
// HEALTH RATIOS
// =====================================

var current_ratio = clamp(global.health_current / global.health_max, 0, 1);
var display_ratio = clamp(health_display / global.health_max, 0, 1);


// =====================================
// DAMAGE FLASH EFFECT
// =====================================

var flash_alpha = 0;

if (health_damage_flash_timer > 0)
{
    flash_alpha = 0.25;
}


// =====================================
// SHADOW
// =====================================

draw_set_alpha(0.40);
draw_set_color(c_black);

draw_roundrect(
    bar_x - 12,
    bar_y - 12,
    bar_x + bar_w + 12,
    bar_y + bar_h + 12,
    false
);


// =====================================
// OUTER FRAME
// =====================================

draw_set_alpha(1);
draw_set_color(make_color_rgb(30, 30, 30));

draw_roundrect(
    bar_x - 6,
    bar_y - 6,
    bar_x + bar_w + 6,
    bar_y + bar_h + 6,
    false
);


// =====================================
// INNER FRAME
// =====================================

draw_set_color(make_color_rgb(70, 70, 70));

draw_roundrect(
    bar_x - 2,
    bar_y - 2,
    bar_x + bar_w + 2,
    bar_y + bar_h + 2,
    false
);


// =====================================
// EMPTY BAR
// =====================================

draw_set_color(make_color_rgb(15, 15, 15));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    false
);


// =====================================
// DELAYED DAMAGE BAR
// =====================================

draw_set_color(make_color_rgb(125, 20, 20));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * display_ratio),
    bar_y + bar_h,
    false
);


// =====================================
// HEALTH COLOR
// =====================================

if (current_ratio > 0.60)
{
    draw_set_color(make_color_rgb(0, 220, 80));
}
else if (current_ratio > health_critical_percent)
{
    draw_set_color(make_color_rgb(255, 190, 0));
}
else
{
    draw_set_color(make_color_rgb(220, 40, 40));
}


// =====================================
// CURRENT HEALTH BAR
// =====================================

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * current_ratio),
    bar_y + bar_h,
    false
);


// =====================================
// TOP HIGHLIGHT
// =====================================

if (current_ratio > 0)
{
    draw_set_alpha(0.22);
    draw_set_color(c_white);

    draw_roundrect(
        bar_x + 4,
        bar_y + 4,
        bar_x + (bar_w * current_ratio) - 4,
        bar_y + (bar_h * 0.45),
        false
    );
}


// =====================================
// DAMAGE FLASH OVERLAY
// =====================================

if (flash_alpha > 0)
{
    draw_set_alpha(flash_alpha);
    draw_set_color(c_white);

    draw_roundrect(
        bar_x,
        bar_y,
        bar_x + bar_w,
        bar_y + bar_h,
        false
    );
}


// =====================================
// CRITICAL HEALTH WARNING BORDER
// =====================================

draw_set_alpha(1);

if (health_is_critical)
{
    draw_set_color(c_red);
}
else
{
    draw_set_color(c_white);
}

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    true
);


// =====================================
// TITLE
// =====================================

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_white);

draw_text(
    bar_x + (bar_w * 0.5),
    bar_y - 8,
    "HEALTH"
);


// =====================================
// HEALTH TEXT
// =====================================

draw_set_valign(fa_middle);

draw_text(
    bar_x + (bar_w * 0.5),
    bar_y + (bar_h * 0.5),
    string(floor(global.health_current)) + " / " + string(global.health_max)
);
// =====================================

if (is_dead)
{
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var msg_x = gui_w * 0.5;
    var msg_y = gui_h * 0.5;

    // Blinking animation
    var blink_alpha = 0.55 + (0.45 * abs(sin(current_time * 0.006)));

    // Slight pulsing size
    var text_scale = 1.0 + (0.08 * abs(sin(current_time * 0.004)));

    // White transparent full-screen background
    draw_set_alpha(0.35);
    draw_set_color(c_white);

    draw_rectangle(
        0,
        0,
        gui_w,
        gui_h,
        false
    );

    // Dark transparent center strip across screen
    draw_set_alpha(0.55);
    draw_set_color(c_black);

    draw_rectangle(
        0,
        msg_y - 80,
        gui_w,
        msg_y + 80,
        false
    );

    // Red accent lines
    draw_set_alpha(blink_alpha);
    draw_set_color(make_color_rgb(180, 20, 20));

    draw_rectangle(
        0,
        msg_y - 85,
        gui_w,
        msg_y - 78,
        false
    );

    draw_rectangle(
        0,
        msg_y + 78,
        gui_w,
        msg_y + 85,
        false
    );

    // Text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Text shadow
    draw_set_alpha(blink_alpha);
    draw_set_color(c_black);

    draw_text_transformed(
        msg_x + 4,
        msg_y + 4,
        "YOU HAVE DIED!",
        text_scale,
        text_scale,
        0
    );

    // Main blinking text
    draw_set_alpha(blink_alpha);
    draw_set_color(make_color_rgb(230, 30, 30));

    draw_text_transformed(
        msg_x,
        msg_y,
        "YOU HAVE DIED!",
        text_scale,
        text_scale,
        0
    );

    // Small subtitle
    draw_set_alpha(0.85);
    draw_set_color(c_white);

    draw_text(
        msg_x,
        msg_y + 52,
        "RESPAWNING..."
    );
}
// =====================================
// RESET DRAW SETTINGS
// =====================================

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// =====================================
// ENEMY ELIMINATED MESSAGE
// =====================================

if (global.enemy_eliminated_message_timer > 0)
{
    var gui_w = display_get_gui_width();

    var msg_x = gui_w * 0.5;
    var msg_y = 95;

    var alpha =
        global.enemy_eliminated_message_timer /
        global.enemy_eliminated_message_duration;

    var scale =
        1.0 + (0.05 * abs(sin(current_time * 0.01)));

    // Background strip
    draw_set_alpha(alpha * 0.35);
    draw_set_color(c_black);

    draw_rectangle(
        msg_x - 230,
        msg_y - 24,
        msg_x + 230,
        msg_y + 24,
        false
    );

    // Text
    draw_set_alpha(alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Shadow
    draw_set_color(c_black);

    draw_text_transformed(
        msg_x + 2,
        msg_y + 2,
        global.enemy_eliminated_message_text,
        scale,
        scale,
        0
    );

    // Main text
    draw_set_color(make_color_rgb(255, 220, 60));

    draw_text_transformed(
        msg_x,
        msg_y,
        global.enemy_eliminated_message_text,
        scale,
        scale,
        0
    );
}


// =====================================
// RESET DRAW SETTINGS
// =====================================

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);


