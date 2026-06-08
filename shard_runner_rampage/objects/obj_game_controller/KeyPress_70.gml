var l3E3A6E13_0;
l3E3A6E13_0 = keyboard_check_pressed(ord("F"));
if (l3E3A6E13_0)
{
	room_restart();

	audio_stop_all();

	global.health_current = global.health_max;
}