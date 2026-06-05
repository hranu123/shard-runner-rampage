// =====================================
// WEAPON AND SWORD SYSTEM
// =====================================


// =====================================
// CHOOSE CHARACTER SPRITE + FRAME
// =====================================

var draw_sprite_to_use = sprite_index;
var draw_frame = image_index;


// Sword attack sprites override normal sprite
if (global.equipped_weapon == "sword" && is_sword_attacking)
{
    if (facing_dir == "up") draw_sprite_to_use = spr_main_character_attack_up;
    else if (facing_dir == "down") draw_sprite_to_use = spr_main_character_attack_down;
    else if (facing_dir == "left") draw_sprite_to_use = spr_main_character_attack_left;
    else if (facing_dir == "right") draw_sprite_to_use = spr_main_character_attack_right;

    draw_frame = sword_attack_frame;
}


// Keep frame within range
draw_frame = floor(draw_frame);

var frame_count = sprite_get_number(draw_sprite_to_use);

if (draw_frame >= frame_count) draw_frame = frame_count - 1;
if (draw_frame < 0) draw_frame = 0;


// Draw character once
draw_sprite(
    draw_sprite_to_use,
    draw_frame,
    x,
    y - jump_z
);


// =====================================
// DRAW GUNS ONLY WHEN WEAPON IS NOT SWORD
// 360 AIMING + HAND-BASED POSITIONING
// =====================================

if (global.equipped_weapon != noone && global.equipped_weapon != "sword")
{
    var weapon_sprite = noone;

    if (global.equipped_weapon == "pistol") weapon_sprite = spr_pistol;
    if (global.equipped_weapon == "rifle") weapon_sprite = spr_rifle;
    if (global.equipped_weapon == "shotgun") weapon_sprite = spr_shotgun;
    if (global.equipped_weapon == "rpg") weapon_sprite = spr_rpg;

    if (weapon_sprite != noone)
    {
        var base_y = y - jump_z;

        // Gun aims toward mouse
        var aim_dir = point_direction(x, base_y, mouse_x, mouse_y);

        // Default hand position
        var hand_x = x;
        var hand_y = base_y;

        // Adjust hand anchor based on character facing direction
        if (facing_dir == "right")
        {
            hand_x = x + 65;
            hand_y = base_y + 45;
        }
        else if (facing_dir == "left")
        {
            hand_x = x + 4;
            hand_y = base_y + 45;
        }
        else if (facing_dir == "up")
        {
            hand_x = x + 30;
            hand_y = base_y + 45;
        }
        else if (facing_dir == "down")
        {
            hand_x = x + 30;
            hand_y = base_y + 60;
        }

        // Pull weapon slightly toward aim direction
        var gun_distance = 4;

        var gun_x = hand_x + lengthdir_x(gun_distance, aim_dir);
        var gun_y = hand_y + lengthdir_y(gun_distance, aim_dir);

        var gun_angle = aim_dir;

        var gun_xscale = 1;
        var gun_yscale = 1;

        // Flip weapon correctly when aiming left
        if (aim_dir > 90 && aim_dir < 270)
        {
            gun_yscale = -1;
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