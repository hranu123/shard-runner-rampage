// =====================================
// DRAW ENEMY
// =====================================

draw_self();


// =====================================
// LARGE PROFESSIONAL ENEMY HEALTH BAR
// Always visible directly above enemy
// =====================================

var bar_w = 115;
var bar_h = 20;

// Negative Y places it above the enemy
var bar_x = x - (bar_w * 0.5);
var bar_y = y - 80;

var current_ratio = clamp(enemy_health_current / enemy_health_max, 0, 1);
var display_ratio = clamp(enemy_health_display / enemy_health_max, 0, 1);


// Shadow
draw_set_alpha(0.45);
draw_set_color(c_black);

draw_roundrect(
    bar_x - 4,
    bar_y - 4,
    bar_x + bar_w + 4,
    bar_y + bar_h + 4,
    false
);


// Outer dark frame
draw_set_alpha(1);
draw_set_color(make_color_rgb(25, 25, 25));

draw_roundrect(
    bar_x - 3,
    bar_y - 3,
    bar_x + bar_w + 3,
    bar_y + bar_h + 3,
    false
);


// Inner empty background
draw_set_color(make_color_rgb(10, 10, 10));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + bar_w,
    bar_y + bar_h,
    false
);


// Delayed damage bar
draw_set_color(make_color_rgb(120, 25, 25));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * display_ratio),
    bar_y + bar_h,
    false
);


// Current health bar
draw_set_color(make_color_rgb(235, 45, 45));

draw_roundrect(
    bar_x,
    bar_y,
    bar_x + (bar_w * current_ratio),
    bar_y + bar_h,
    false
);


// Small top highlight
draw_set_alpha(0.25);
draw_set_color(c_white);

draw_rectangle(
    bar_x + 2,
    bar_y + 2,
    bar_x + (bar_w * current_ratio) - 2,
    bar_y + 4,
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


// Clean white border
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