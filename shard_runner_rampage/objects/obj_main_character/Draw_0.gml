// =====================================
// WEAPON AND SWORD SYSTEM - DRAW EVENT
// =====================================


// =====================================
// CHOOSE CHARACTER SPRITE + FRAME
// =====================================

var draw_sprite_to_use = sprite_index;
var draw_frame = image_index;


// Sword attack sprites override normal sprite
if (global.equipped_weapon == "sword" && is_sword_attacking)
{
    if (facing_dir == "up")
    {
        draw_sprite_to_use = spr_main_character_attack_up;
    }
    else if (facing_dir == "down")
    {
        draw_sprite_to_use = spr_main_character_attack_down;
    }
    else if (facing_dir == "left")
    {
        draw_sprite_to_use = spr_main_character_attack_left;
    }
    else if (facing_dir == "right")
    {
        draw_sprite_to_use = spr_main_character_attack_right;
    }

    // IMPORTANT:
    // Sword attack uses its own frame counter
    draw_frame = sword_attack_frame;
}


// =====================================
// KEEP FRAME WITHIN SPRITE FRAME RANGE
// =====================================

draw_frame = floor(draw_frame);

var frame_count = sprite_get_number(draw_sprite_to_use);

if (draw_frame >= frame_count)
{
    draw_frame = frame_count - 1;
}

if (draw_frame < 0)
{
    draw_frame = 0;
}


// =====================================
// DRAW CHARACTER ONCE
// =====================================

draw_sprite(
    draw_sprite_to_use,
    draw_frame,
    x,
    y - jump_z
);


// =====================================
// DRAW GUNS ONLY WHEN WEAPON IS NOT SWORD
// =====================================

if (global.equipped_weapon != noone && global.equipped_weapon != "sword")
{
    var weapon_sprite = noone;

    if (global.equipped_weapon == "pistol") weapon_sprite = spr_pistol;
    if (global.equipped_weapon == "rifle") weapon_sprite = spr_rifle;
    if (global.equipped_weapon == "shotgun") weapon_sprite = spr_shotgun;

    if (weapon_sprite != noone)
    {
        var dx = mouse_x - x;
        var dy = mouse_y - y;

        var base_y = y - jump_z;

        var gun_x = x;
        var gun_y = base_y;

        var gun_angle = 0;
        var gun_xscale = 1;
        var gun_yscale = 1;

        if (abs(dx) > abs(dy))
        {
            if (dx > 0)
            {
                gun_x = x + 10;
                gun_y = base_y - 2;
                gun_angle = 0;
                gun_xscale = 1;
            }
            else
            {
                gun_x = x - 10;
                gun_y = base_y - 2;
                gun_angle = 0;
                gun_xscale = -1;
            }
        }
        else
        {
            if (dy < 0)
            {
                gun_x = x;
                gun_y = base_y + 8;
                gun_angle = 90;
            }
            else
            {
                gun_x = x;
                gun_y = base_y - 10;
                gun_angle = 270;
            }
        }

        draw_sprite_ext(
            weapon_sprite,
            0,
            gun_x,
            gun_y,
            gun_xscale,
            gun_yscale,
            gun_angle,
            c_white,
            1
        );
    }
}