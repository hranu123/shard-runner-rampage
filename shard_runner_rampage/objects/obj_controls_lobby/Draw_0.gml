/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 6309C4C3
/// @DnDArgument : "code" "if (hovering)$(13_10){$(13_10)    draw_set_alpha(0.35);$(13_10)    draw_set_colour(c_white);$(13_10)$(13_10)    draw_rectangle($(13_10)        bbox_left - 8,$(13_10)        bbox_top - 8,$(13_10)        bbox_right + 8,$(13_10)        bbox_bottom + 8,$(13_10)        false$(13_10)    );$(13_10)$(13_10)    draw_set_alpha(1);$(13_10)}$(13_10)$(13_10)$(13_10)draw_self();$(13_10)"
if (hovering)
{
    draw_set_alpha(0.35);
    draw_set_colour(c_white);

    draw_rectangle(
        bbox_left - 8,
        bbox_top - 8,
        bbox_right + 8,
        bbox_bottom + 8,
        false
    );

    draw_set_alpha(1);
}


draw_self();