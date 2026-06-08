/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
/// @DnDVersion : 1
/// @DnDHash : 3E3A6E13
/// @DnDArgument : "key" "ord("R")"
var l3E3A6E13_0;
l3E3A6E13_0 = keyboard_check_pressed(ord("R"));
if (l3E3A6E13_0)
{
	/// @DnDAction : YoYo Games.Rooms.Restart_Room
	/// @DnDVersion : 1
	/// @DnDHash : 54851133
	/// @DnDParent : 3E3A6E13
	room_restart();

	/// @DnDAction : YoYo Games.Audio.Stop_All_Audio
	/// @DnDVersion : 1
	/// @DnDHash : 7B5385D7
	/// @DnDParent : 3E3A6E13
	audio_stop_all();

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 70513870
	/// @DnDParent : 3E3A6E13
	/// @DnDArgument : "expr" "global.max_health"
	/// @DnDArgument : "var" "global.health"
	global.health = global.max_health;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7D2398F9
	/// @DnDParent : 3E3A6E13
	/// @DnDArgument : "expr" "global.max_lives"
	/// @DnDArgument : "var" "global.lives"
	global.lives = global.max_lives;
}