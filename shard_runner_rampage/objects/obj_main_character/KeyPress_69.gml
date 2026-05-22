/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 3860AD90
/// @DnDArgument : "expr" "instance_place(x, y, obj_coin)"
/// @DnDArgument : "var" "var_coin_to_collect"
var_coin_to_collect = instance_place(x, y, obj_coin);

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 2F9AF5D7
/// @DnDArgument : "var" "instance_exists(var_coin_to_collect)"
/// @DnDArgument : "value" "true"
if(instance_exists(var_coin_to_collect) == true)
{
	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 44675B80
	/// @DnDParent : 2F9AF5D7
	/// @DnDArgument : "value" "1"
	/// @DnDArgument : "value_relative" "1"
	/// @DnDArgument : "var" "global.var_coincount"
	global.var_coincount += 1;

	/// @DnDAction : YoYo Games.Audio.Play_Audio
	/// @DnDVersion : 1.1
	/// @DnDHash : 16D74014
	/// @DnDParent : 2F9AF5D7
	/// @DnDArgument : "soundid" "snd_coin_collect"
	/// @DnDSaveInfo : "soundid" "snd_coin_collect"
	audio_play_sound(snd_coin_collect, 0, 0, 1.0, undefined, 1.0);

	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 1A98F2E5
	/// @DnDApplyTo : var_coin_to_collect
	/// @DnDParent : 2F9AF5D7
	with(var_coin_to_collect) instance_destroy();
}