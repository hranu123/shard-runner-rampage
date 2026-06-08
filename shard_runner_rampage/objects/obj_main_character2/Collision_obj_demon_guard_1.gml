/// @DnDAction : YoYo Games.Movement.Set_Speed
/// @DnDVersion : 1
/// @DnDHash : 6D496BD7
speed = 0;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 3BE432ED
/// @DnDArgument : "var" "var_can_take_damage"
/// @DnDArgument : "value" "true"
if(var_can_take_damage == true)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 4010401A
	/// @DnDParent : 3BE432ED
	/// @DnDArgument : "expr" "-100"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "global.health"
	global.health += -100;

	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 58DEB700
	/// @DnDParent : 3BE432ED
	/// @DnDArgument : "var" "global.health"
	/// @DnDArgument : "op" "3"
	if(global.health <= 0)
	{
		/// @DnDAction : YoYo Games.Audio.Play_Audio
		/// @DnDVersion : 1.1
		/// @DnDHash : 02895451
		/// @DnDParent : 58DEB700
		/// @DnDArgument : "soundid" "snd_guard_laughing_after_player_death"
		/// @DnDSaveInfo : "soundid" "snd_guard_laughing_after_player_death"
		audio_play_sound(snd_guard_laughing_after_player_death, 0, 0, 1.0, undefined, 1.0);
	
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 00B1EEE3
		/// @DnDParent : 58DEB700
		/// @DnDArgument : "expr" ""knight""
		/// @DnDArgument : "var" "global.death_cause"
		global.death_cause = "knight";
	
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 1527BC7F
		/// @DnDParent : 58DEB700
		/// @DnDArgument : "var" "global.health"
		global.health = 0;
	}

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 2B99820A
	/// @DnDParent : 3BE432ED
	/// @DnDArgument : "expr" "false"
	/// @DnDArgument : "var" "var_can_take_damage"
	var_can_take_damage = false;
}