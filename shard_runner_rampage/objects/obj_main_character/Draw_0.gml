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
    if (facing_dir == "up") draw_sprite_to_use = spr_main_character_attack_up;
    else if (facing_dir == "down") draw_sprite_to_use = spr_main_character_attack_down;
    else if (facing_dir == "left") draw_sprite_to_use = spr_main_character_attack_left;
    else if (facing_dir == "right") draw_sprite_to_use = spr_main_character_attack_right;

    draw_frame = sword_attack_frame;
}


// Keep frame within sprite range WITHOUT forcing floor
var frame_count = sprite_get_number(draw_sprite_to_use);

if (draw_frame >= frame_count) draw_frame = frame_count - 1;
if (draw_frame < 0) draw_frame = 0;


// Draw character
draw_sprite(
    draw_sprite_to_use,
    draw_frame,
    x,
    y - jump_z
);


// =====================================
// DRAW GUNS ONLY WHEN EQUIPPED WEAPON IS NOT SWORD
// =====================================

if (global.equipped_weapon != noone && global.equipped_weapon != "sword")
{
    var weapon_sprite = noone;

    if (global.equipped_weapon == "pistol") weapon_sprite = spr_pistol;
    else if (global.equipped_weapon == "rifle") weapon_sprite = spr_rifle;
    else if (global.equipped_weapon == "shotgun") weapon_sprite = spr_shotgun;
    else if (global.equipped_weapon == "rpg") weapon_sprite = spr_rpg;

    if (weapon_sprite != noone)
    {
        var base_y = y - jump_z;

        // Hand position values
        var right_hand_x = 65;
        var right_hand_y = 45;

        var left_hand_x = 4;
        var left_hand_y = 45;

        var gun_distance = 4;

        // Aim toward mouse
        var aim_dir = point_direction(x, base_y, mouse_x, mouse_y);

        var hand_x = x;
        var hand_y = base_y;

        // Choose hand anchor
        if (facing_dir == "left")
        {
            hand_x = x + left_hand_x;
            hand_y = base_y + left_hand_y;
        }
        else
        {
            hand_x = x + right_hand_x;
            hand_y = base_y + right_hand_y;
        }

        // Final gun position
        var gun_x = hand_x + lengthdir_x(gun_distance, aim_dir);
        var gun_y = hand_y + lengthdir_y(gun_distance, aim_dir);

        // Flip gun when aiming left
        var gun_yscale = 1;

        if (aim_dir > 90 && aim_dir < 270)
        {
            gun_yscale = -1;
        }

        // Draw weapon
        draw_sprite_ext(
            weapon_sprite,
            0,
            gun_x,
            gun_y,
            1,
            gun_yscale,
            aim_dir,
            c_white,
            1
        );
    }
}