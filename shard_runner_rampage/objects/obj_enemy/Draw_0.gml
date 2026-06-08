// =====================================
// DRAW ENEMY
// =====================================

draw_self();


// =====================================
// ENEMY HEALTH BAR
// =====================================

var bar_w = enemy_health_bar_width;
var bar_h = enemy_health_bar_height;

var bar_x = x - (bar_w * 0.1);
var bar_y = y + enemy_health_bar_y_offset;

var current_ratio = clamp(enemy_health_current / enemy_health_max, 0, 1);
var display_ratio = clamp(enemy_health_display / enemy_health_max, 0, 1);


// Shadow
draw_set_alpha(0.45);
draw_set_color(c_black);

draw_roundrect(
    bar_x - 3,
    bar_y - 3,
    bar_x + bar_w + 3,
    bar_y + bar_h + 3,
    false
);


// Outer frame
draw_set_alpha(1);
draw_set_color(make_color_rgb(35, 35, 35));

draw_roundrect(
    bar_x - 2,
    bar_y - 2,
    bar_x + bar_w + 2,
    bar_y + bar_h + 2,
    false
);


// Empty bar
draw_set_color(make_color_rgb(20, 20, 20));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    false
);


// Delayed damage bar
draw_set_color(make_color_rgb(120, 20, 20));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * display_ratio),
    bar_y + bar_h,
    false
);


// Current health
draw_set_color(make_color_rgb(230, 40, 40));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * current_ratio),
    bar_y + bar_h,
    false
);


// Damage flash
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


// Border
draw_set_alpha(1);
draw_set_color(c_white);

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    true
);


// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);