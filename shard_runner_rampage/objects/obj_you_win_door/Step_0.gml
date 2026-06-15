/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 6014EF1E
/// @DnDArgument : "expr" "place_meeting(x, y, obj_main_character)"
/// @DnDArgument : "var" "player_touching_door"
player_touching_door = place_meeting(x, y, obj_main_character);

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 69E6966B
/// @DnDArgument : "var" "door_sequence_started"
/// @DnDArgument : "value" "true"
if(door_sequence_started == true)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 4B46D7AD
	/// @DnDParent : 69E6966B
	/// @DnDArgument : "expr" "-1"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "transport_timer"
	transport_timer += -1;
}