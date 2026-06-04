/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 64A8DF55
/// @DnDArgument : "expr" "distance_to_object(obj_main_character) <= guard_walk_detect_range ||( global.player_sprinting == true && distance_to_object(obj_main_character) <= guard_sprint_detect_range)"
if(distance_to_object(obj_main_character) <= guard_walk_detect_range ||( global.player_sprinting == true && distance_to_object(obj_main_character) <= guard_sprint_detect_range))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7E21A72E
	/// @DnDParent : 64A8DF55
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "global.has_discovered_player11"
	global.has_discovered_player11 = true;
}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 1051E1D8
/// @DnDArgument : "var" "global.has_discovered_player11"
/// @DnDArgument : "value" "true"
if(global.has_discovered_player11 == true)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 1FCF64E4
	/// @DnDParent : 1051E1D8
	/// @DnDArgument : "expr" "point_direction(x, y, obj_main_character.x, obj_main_character.y)"
	/// @DnDArgument : "var" "direction"
	direction = point_direction(x, y, obj_main_character.x, obj_main_character.y);

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 63795057
	/// @DnDParent : 1051E1D8
	/// @DnDArgument : "expr" "guard_chase_speed"
	/// @DnDArgument : "var" "speed"
	speed = guard_chase_speed;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 5F51724F
	/// @DnDParent : 1051E1D8
	/// @DnDArgument : "expr" "guard_chase_animation_speed"
	/// @DnDArgument : "var" "guard_animation_speed"
	guard_animation_speed = guard_chase_animation_speed;

	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 1B110DC0
	/// @DnDParent : 1051E1D8
	/// @DnDArgument : "code" "if (global.alarm_active == false)$(13_10){$(13_10)    global.alarm_active = true;$(13_10)    global.alarm_sound_id = audio_play_sound(snd_alarm, 10, true);$(13_10)}"
	if (global.alarm_active == false)
	{
	    global.alarm_active = true;
	    global.alarm_sound_id = audio_play_sound(snd_alarm, 10, true);
	}
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 055F755D
else
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 13477104
	/// @DnDParent : 055F755D
	/// @DnDArgument : "expr" "guard_patrol_direction"
	/// @DnDArgument : "var" "direction"
	direction = guard_patrol_direction;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 2F82C37F
	/// @DnDParent : 055F755D
	/// @DnDArgument : "expr" "guard_patrol_speed"
	/// @DnDArgument : "var" "speed"
	speed = guard_patrol_speed;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 2AF82229
	/// @DnDParent : 055F755D
	/// @DnDArgument : "expr" "guard_patrol_animation_speed"
	/// @DnDArgument : "var" "guard_animation_speed"
	guard_animation_speed = guard_patrol_animation_speed;

	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 21DD46A0
	/// @DnDParent : 055F755D
	/// @DnDArgument : "code" "if (global.guard_turn_cooldown > 0)$(13_10){$(13_10)    global.guard_turn_cooldown -= 1;$(13_10)}$(13_10)$(13_10)$(13_10)if (place_meeting(x, y, obj_knight_blocker) && global.guard_turn_cooldown <= 0)$(13_10){$(13_10)    x -= lengthdir_x(guard_patrol_speed + 2, guard_patrol_direction);$(13_10)    y -= lengthdir_y(guard_patrol_speed + 2, guard_patrol_direction);$(13_10)$(13_10)  $(13_10)    var old_dir = guard_patrol_direction;$(13_10)$(13_10)  $(13_10)    repeat (10)$(13_10)    {$(13_10)        guard_patrol_direction = choose(0, 90, 180, 270);$(13_10)$(13_10)        if (guard_patrol_direction != old_dir)$(13_10)        {$(13_10)            break;$(13_10)        }$(13_10)    }$(13_10)$(13_10)    $(13_10)    guard_turn_cooldown = 45;$(13_10)}$(13_10)"
	if (global.guard_turn_cooldown > 0)
	{
	    global.guard_turn_cooldown -= 1;
	}
	
	
	if (place_meeting(x, y, obj_knight_blocker) && global.guard_turn_cooldown <= 0)
	{
	    x -= lengthdir_x(guard_patrol_speed + 2, guard_patrol_direction);
	    y -= lengthdir_y(guard_patrol_speed + 2, guard_patrol_direction);
	
	  
	    var old_dir = guard_patrol_direction;
	
	  
	    repeat (10)
	    {
	        guard_patrol_direction = choose(0, 90, 180, 270);
	
	        if (guard_patrol_direction != old_dir)
	        {
	            break;
	        }
	    }
	
	    
	    guard_turn_cooldown = 45;
	}
}