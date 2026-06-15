/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 20295D8A
/// @DnDArgument : "var" "player_touching_door"
/// @DnDArgument : "value" "true"
if(player_touching_door == true)
{
	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 04AD278A
	/// @DnDParent : 20295D8A
	/// @DnDArgument : "var" "door_sequence_started"
	/// @DnDArgument : "value" "false"
	if(door_sequence_started == false)
	{
		/// @DnDAction : YoYo Games.Drawing.Set_Font
		/// @DnDVersion : 1
		/// @DnDHash : 47A6A35C
		/// @DnDParent : 04AD278A
		/// @DnDArgument : "font" "fnt_door"
		draw_set_font(fnt_door);
	
		/// @DnDAction : YoYo Games.Drawing.Set_Color
		/// @DnDVersion : 1
		/// @DnDHash : 47188EC9
		/// @DnDParent : 04AD278A
		/// @DnDArgument : "color" "$FF06A2E5"
		/// @DnDArgument : "alpha" "false"
		draw_set_colour($FF06A2E5 & $ffffff);draw_set_alpha(1);
	
		/// @DnDAction : YoYo Games.Drawing.Draw_Value
		/// @DnDVersion : 1
		/// @DnDHash : 37CE9465
		/// @DnDParent : 04AD278A
		/// @DnDArgument : "x" "500"
		/// @DnDArgument : "y" "600"
		/// @DnDArgument : "caption" ""Press V To Win""
		draw_text(500, 600, string("Press V To Win") + "");
	}
}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 43D3D89D
/// @DnDArgument : "var" "door_sequence_started"
/// @DnDArgument : "value" "true"
if(door_sequence_started == true)
{
	/// @DnDAction : YoYo Games.Drawing.Set_Font
	/// @DnDVersion : 1
	/// @DnDHash : 503155EE
	/// @DnDParent : 43D3D89D
	/// @DnDArgument : "font" "fnt_gui"
	draw_set_font(fnt_gui);

	/// @DnDAction : YoYo Games.Drawing.Set_Color
	/// @DnDVersion : 1
	/// @DnDHash : 523879C5
	/// @DnDParent : 43D3D89D
	/// @DnDArgument : "color" "$FF000000"
	draw_set_colour($FF000000 & $ffffff);
	var l523879C5_0=($FF000000 >> 24);
	draw_set_alpha(l523879C5_0 / $ff);

	/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
	/// @DnDVersion : 1
	/// @DnDHash : 40F2F21D
	/// @DnDParent : 43D3D89D
	/// @DnDArgument : "x" " 500+ random_range(-(30 - transport_timer), (30 - transport_timer))"
	/// @DnDArgument : "y" "600+ random_range(-(30 - transport_timer), (30 - transport_timer))"
	/// @DnDArgument : "caption" ""Incorrect Door! ""
	/// @DnDArgument : "angle" "random_range(-2,2)"
	draw_text_transformed( 500+ random_range(-(30 - transport_timer), (30 - transport_timer)), 600+ random_range(-(30 - transport_timer), (30 - transport_timer)), string("Incorrect Door! ") + "", 1, 1, random_range(-2,2));
}