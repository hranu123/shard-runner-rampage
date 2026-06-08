/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 64FE2C9F
/// @DnDArgument : "code" "hovering = position_meeting(mouse_x, mouse_y, id);$(13_10)$(13_10)if (hovering)$(13_10){$(13_10)    image_xscale = lerp(image_xscale, 1.1, 0.15);$(13_10)    image_yscale = lerp(image_yscale, 1.1, 0.15);$(13_10)}$(13_10)else$(13_10){$(13_10)    image_xscale = lerp(image_xscale, 1, 0.15);$(13_10)    image_yscale = lerp(image_yscale, 1, 0.15);$(13_10)}"
hovering = position_meeting(mouse_x, mouse_y, id);

if (hovering)
{
    image_xscale = lerp(image_xscale, 1.1, 0.15);
    image_yscale = lerp(image_yscale, 1.1, 0.15);
}
else
{
    image_xscale = lerp(image_xscale, 1, 0.15);
    image_yscale = lerp(image_yscale, 1, 0.15);
}