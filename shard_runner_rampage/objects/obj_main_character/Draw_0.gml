// Draw the character first
draw_self();


// Only draw a weapon if one is equipped
if (global.equipped_weapon != noone)
{
    // Convert equipped weapon name into the correct sprite
    var weapon_sprite = noone;

    if (global.equipped_weapon == "pistol")
    {
        weapon_sprite = spr_pistol;
    }

    if (global.equipped_weapon == "rifle")
    {
        weapon_sprite = spr_rifle;
    }


    // Draw the correct weapon sprite
    if (weapon_sprite != noone)
    {
        var dx = mouse_x - x;
        var dy = mouse_y - y;

        var gun_x = x;
        var gun_y = y;

        var gun_angle = 0;
        var gun_xscale = 1;
        var gun_yscale = 1;


        // LEFT / RIGHT
        if (abs(dx) > abs(dy))
        {
            if (dx > 0)
            {
                // Facing right
                gun_x = x + 10;
                gun_y = y - 2;

                gun_angle = 0;
               gun_xscale = 1;
				gun_yscale = 1;
            }
            else
            {
                // Facing left
                gun_x = x - 10;
                gun_y = y - 2;

                gun_angle = 0;
             gun_xscale = - 1;
				gun_yscale = 1;
            }
        }
		
        else
        {
            if (dy < 0)
            {
                // Facing up
                gun_x = x;
               gun_y = y + 8;
                gun_angle = 90;
                gun_xscale = 1;
				gun_yscale = 1;
			}
            else
            {
                // Facing down
                gun_x = x;
                 gun_y = y - 10;

                gun_angle = 270;
               gun_xscale = 1;
				gun_yscale = 1;
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