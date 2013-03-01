use strict;

Xchat::register("Autorejoin", "1.0");
Xchat::print("Autorejoin script loaded\n");

Xchat::hook_print('You Kicked', sub {
	Xchat::hook_timer(1500, sub {
		Xchat::command("join $_[0]");
		return Xchat::REMOVE;
	}, $_[0][1]);

	return Xchat::EAT_NONE;
});
