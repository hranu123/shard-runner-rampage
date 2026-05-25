var slot_size = 64;
var start_x = 40;
var start_y = 40;
var gap = 10;

for (var i = 0; i < 5; i++)
{
    var slot_x = start_x + i * (slot_size + gap);
    var slot_y = start_y;

    // Draw slot box first
    draw_set_colour(c_white);
    draw_rectangle(slot_x, slot_y, slot_x + slot_size, slot_y + slot_size, false);

    // Draw selected highlight
    if (global.selected_weapon_slot == i)
    {
        draw_set_colour(c_yellow);
        draw_rectangle(slot_x - 3, slot_y - 3, slot_x + slot_size + 3, slot_y + slot_size + 3, false);
    }

    // Draw weapon ABOVE the box
    if (global.weapon_inventory[i] != noone)
    {
        draw_sprite_ext(
            global.weapon_inventory[i],
            0,
            slot_x + slot_size / 2,
            slot_y + slot_size / 2,
            1,
            1,
            0,
            c_white,
            1
        );
    }

    // Draw slot number last
    draw_set_colour(c_white);
    draw_text(slot_x + 24, slot_y + 70, string(i + 1));
}