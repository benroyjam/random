use strict;

Xchat::register("AutoGetkey", "1.0");
Xchat::print("AutoGetkey script loaded\n");

Xchat::hook_print('Keyword', sub {
	my $channel = $_[0][0];

	my $getkeyHook;
	$getkeyHook = Xchat::hook_print('Notice', sub {
		my $hookRef = $_[1];
		my $hook = $$hookRef;
		my $key = '';

		if ($_[0][1] =~ /KEY $channel (.*)/) {
			Xchat::unhook($hook);
			$key = $1;
		}

		elsif ($_[0][1] eq 'Access denied.') {
			Xchat::unhook($hook);
		}

		if ($key) {
			Xchat::command("join $channel $key");
		}

		return Xchat::EAT_NONE;
	}, { data => \$getkeyHook });
	Xchat::command("msg ChanServ getkey $channel");

	return Xchat::EAT_NONE;
}, { priority => Xchat::PRI_NORM });
