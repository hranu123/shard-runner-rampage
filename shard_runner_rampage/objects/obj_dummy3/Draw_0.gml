// =====================================
// DRAW ENEMY
// =====================================

draw_self();

// =====================================
// LARGE PROFESSIONAL DUMMY HEALTH BAR
// =====================================

var bar_w = 360;
var bar_h = 34;

// Health bar position
var bar_x = x - (bar_w * 0.5) + 225;
var bar_y = y - 150;

var current_ratio = clamp(enemy_health_current / enemy_health_max, 0, 1);
var display_ratio = clamp(enemy_health_display / enemy_health_max, 0, 1);


// Shadow
draw_set_alpha(0.45);
draw_set_color(c_black);
draw_roundrect(bar_x - 8, bar_y - 8, bar_x + bar_w + 8, bar_y + bar_h + 8, false);


// Outer frame
draw_set_alpha(1);
draw_set_color(make_color_rgb(25, 25, 25));
draw_roundrect(bar_x - 5, bar_y - 5, bar_x + bar_w + 5, bar_y + bar_h + 5, false);


// Empty background
draw_set_color(make_color_rgb(10, 10, 10));
draw_roundrect(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);


// Delayed damage bar
draw_set_color(make_color_rgb(120, 25, 25));
draw_roundrect(bar_x, bar_y, bar_x + (bar_w * display_ratio), bar_y + bar_h, false);


// Current health bar
draw_set_color(make_color_rgb(235, 45, 45));
draw_roundrect(bar_x, bar_y, bar_x + (bar_w * current_ratio), bar_y + bar_h, false);


// Border
draw_set_color(c_white);
draw_roundrect(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);


// Bigger health number
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Increase text size by scaling
var health_text = string(enemy_health_current) + " / " + string(enemy_health_max);

draw_text_transformed(
    x + 230,
    bar_y + (bar_h * 0.5),
    health_text,
    2.2,
    2.2,
    0
);


// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);