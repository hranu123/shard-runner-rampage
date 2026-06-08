var l75D49179_0;
l75D49179_0 = keyboard_check_pressed(ord("Q"));
if (l75D49179_0)
{
	audio_stop_all();

	room_goto(Lobby);
}