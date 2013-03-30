use strict;

Xchat::register("AutoUnban", "1.0");
Xchat::print("AutoUnban script loaded\n");

Xchat::hook_print('Banned', sub {
	my $channel = $_[0][0];

	my $unbanHook;
	$unbanHook = Xchat::hook_print('Notice', sub {
		my $hookRef = $_[1];
		my $hook = $$hookRef;
		my $unbanResult = Xchat::EAT_NONE;
		my $nick = Xchat::get_info('nick');

		if (Xchat::strip_code($_[0][1]) =~ /$nick has been unbanned from $channel\./) {
			Xchat::unhook($hook);
			$unbanResult = Xchat::EAT_XCHAT;
			Xchat::command("join $channel");
		}

		elsif ($_[0][1] eq 'Permission denied.') {
			Xchat::unhook($hook);
		}

		return $unbanResult;
	}, { data => \$unbanHook });

	Xchat::command("msg ChanServ unban $channel");

	return Xchat::EAT_XCHAT;
}, { priority => Xchat::PRI_HIGHEST });
