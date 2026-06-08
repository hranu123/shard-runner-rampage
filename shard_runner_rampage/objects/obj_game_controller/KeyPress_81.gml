/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
/// @DnDVersion : 1
/// @DnDHash : 75D49179
/// @DnDArgument : "key" "ord("Q")"
var l75D49179_0;
l75D49179_0 = keyboard_check_pressed(ord("Q"));
if (l75D49179_0)
{
	/// @DnDAction : YoYo Games.Audio.Stop_All_Audio
	/// @DnDVersion : 1
	/// @DnDHash : 452CF450
	/// @DnDParent : 75D49179
	audio_stop_all();

	/// @DnDAction : YoYo Games.Rooms.Go_To_Room
	/// @DnDVersion : 1
	/// @DnDHash : 25D4B06A
	/// @DnDParent : 75D49179
	/// @DnDArgument : "room" "Lobby"
	/// @DnDSaveInfo : "room" "Lobby"
	room_goto(Lobby);
}