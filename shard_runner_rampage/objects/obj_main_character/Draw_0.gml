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
// DRAW GUNS WHEN EQUIPPED
// Rotates toward mouse in any direction
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

        var aim_dir = point_direction(x, base_y, mouse_x, mouse_y);
        gun_aim_dir = aim_dir;

        var hand_x = x;
        var hand_y = base_y + 55;

        if (facing_dir == "right")
        {
            hand_x = x + 65;
        }
        else if (facing_dir == "left")
        {
            hand_x = x + 5;
        }
        else if (facing_dir == "up")
        {
            hand_x = x + 35;
            hand_y = base_y + 35;
        }
        else if (facing_dir == "down")
        {
            hand_x = x + 35;
            hand_y = base_y + 85;
        }

        var gun_x = hand_x;
        var gun_y = hand_y;

        var gun_yscale = 1;

        if (aim_dir > 90 && aim_dir < 270)
        {
            gun_yscale = -1;
        }

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