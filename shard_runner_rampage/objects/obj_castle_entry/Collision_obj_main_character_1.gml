/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 0D715C94
/// @DnDArgument : "var" "player_touching_door"
/// @DnDArgument : "value" "true"
if(player_touching_door == true)
{
	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7B6CBEE5
	/// @DnDParent : 0D715C94
	/// @DnDArgument : "var" "global.var_coincount"
	/// @DnDArgument : "op" "4"
	/// @DnDArgument : "value" "10"
	if(global.var_coincount >= 10)
	{
		/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 13C0A722
		/// @DnDParent : 7B6CBEE5
		/// @DnDArgument : "var" "door_sequence_started"
		/// @DnDArgument : "value" "false"
		if(door_sequence_started == false)
		{
			/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
			/// @DnDVersion : 1
			/// @DnDHash : 75637048
			/// @DnDParent : 13C0A722
			/// @DnDArgument : "key" "ord("V")"
			var l75637048_0;
			l75637048_0 = keyboard_check_pressed(ord("V"));
			if (l75637048_0)
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 2784CB15
				/// @DnDParent : 75637048
				/// @DnDArgument : "expr" "true"
				/// @DnDArgument : "var" "door_sequence_started"
				door_sequence_started = true;
			
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 741442FD
				/// @DnDParent : 75637048
				/// @DnDArgument : "expr" "30"
				/// @DnDArgument : "var" "transport_timer"
				transport_timer = 30;
			
				/// @DnDAction : YoYo Games.Audio.Play_Audio
				/// @DnDVersion : 1.1
				/// @DnDHash : 16A866BB
				/// @DnDParent : 75637048
				/// @DnDArgument : "soundid" "snd_door_open"
				/// @DnDSaveInfo : "soundid" "snd_door_open"
				audio_play_sound(snd_door_open, 0, 0, 1.0, undefined, 1.0);
			
				/// @DnDAction : YoYo Games.Instances.Set_Alarm
				/// @DnDVersion : 1
				/// @DnDHash : 1E2F7E24
				/// @DnDParent : 75637048
				alarm_set(0, 30);
			}
		}
	}
}