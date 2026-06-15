// =====================================
// DRAW ENEMY
// =====================================

draw_self();


// =====================================
// HEALTH BAR ABOVE ENEMY
// =====================================

var bar_w = 150;
var bar_h = 18;

// Center health bar above enemy collision/sprite bounds
var bar_x = ((bbox_left + bbox_right) * 0.5) - (bar_w * 0.75);

// Move higher/lower by changing this number
var bar_y = bbox_top + 100;

var current_ratio = clamp(enemy_health_current / enemy_health_max, 0, 1);
var display_ratio = clamp(enemy_health_display / enemy_health_max, 0, 1);


// =====================================
// SHADOW
// =====================================

draw_set_alpha(0.45);
draw_set_color(c_black);

draw_roundrect(
    bar_x - 5,
    bar_y - 5,
    bar_x + bar_w + 5,
    bar_y + bar_h + 5,
    false
);


// =====================================
// OUTER FRAME
// =====================================

draw_set_alpha(1);
draw_set_color(make_color_rgb(25, 25, 25));

draw_roundrect(
    bar_x - 3,
    bar_y - 3,
    bar_x + bar_w + 3,
    bar_y + bar_h + 3,
    false
);


// =====================================
// EMPTY BACKGROUND
// =====================================

draw_set_color(make_color_rgb(10, 10, 10));

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

draw_set_color(make_color_rgb(120, 25, 25));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * display_ratio),
    bar_y + bar_h,
    false
);


// =====================================
// CURRENT HEALTH BAR
// =====================================

draw_set_color(make_color_rgb(235, 45, 45));

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
    draw_set_alpha(0.25);
    draw_set_color(c_white);

    draw_rectangle(
        bar_x + 2,
        bar_y + 2,
        bar_x + (bar_w * current_ratio) - 2,
        bar_y + 4,
        false
    );
}


// =====================================
// DAMAGE FLASH
// =====================================

if (enemy_damage_flash_timer > 0)
{
    draw_set_alpha(0.35);
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
// BORDER
// =====================================

draw_set_alpha(1);
draw_set_color(c_white);

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    true
);


// =====================================
// RESET DRAW SETTINGS
// =====================================

draw_set_alpha(1);
draw_set_color(c_white);