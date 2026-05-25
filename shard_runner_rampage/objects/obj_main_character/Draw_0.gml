draw_self();

if (global.equipped_weapon != noone)
{
    var dx = mouse_x - x;
    var dy = mouse_y - y;

    var gun_x = x;
    var gun_y = y;
    var gun_angle = 0;
    var gun_xscale = 1;
    var gun_yscale = 1;

    if (abs(dx) > abs(dy))
    {
        if (dx > 0)
        {
            // RIGHT
            gun_x = x + 18;
            gun_y = y - 4;
            gun_angle = 0;
            gun_xscale = 1;
        }
        else
        {
            // LEFT
            gun_x = x - 18;
            gun_y = y - 4;
            gun_angle = 0;
            gun_xscale = -1;
        }
    }
    else
    {
        if (dy < 0)
        { 
            // UP
            gun_x = x;
           gun_y = y + 10;
            gun_angle = 90;
            gun_xscale = 1;
        }
        else
        {
            // DOWN
            gun_x = x;
            gun_y = y - 18;
            gun_angle = 270;
            gun_xscale = 1;
        }
    }

    draw_sprite_ext(
        spr_pistol,
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