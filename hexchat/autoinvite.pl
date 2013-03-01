use strict;

Xchat::register("AutoInvite", "1.0");
Xchat::print("AutoInvite script loaded\n");

Xchat::hook_print('Invite', sub {
	my $channel = $_[0][0];

	my $invitedHook;
	my $deniedHook;
	$invitedHook = Xchat::hook_print('Invited', sub {
		my $invitedHookRef = $_[1]->{invitedHook};
		my $deniedHookRef = $_[1]->{deniedHook};
		my $invitedHook = $$invitedHookRef;
		my $deniedHook = $$deniedHookRef;

		my $invitedResult = Xchat::EAT_NONE;

		if ($_[0][0] eq $channel) {
			Xchat::unhook($invitedHook);
			Xchat::unhook($deniedHook);
			$invitedResult = Xchat::EAT_XCHAT;
			Xchat::command("join $channel");
		}

		return $invitedResult;
	}, { data => { invitedHook => \$invitedHook, deniedHook => \$deniedHook } });

	$deniedHook = Xchat::hook_print('Notice', sub {
		my $invitedHookRef = $_[1]->{invitedHook};
		my $deniedHookRef = $_[1]->{deniedHook};
		my $invitedHook = $$invitedHookRef;
		my $deniedHook = $$deniedHookRef;

		if ($_[0][1] eq 'Permission denied.') {
			Xchat::unhook($invitedHook);
			Xchat::unhook($deniedHook);
		}

		return Xchat::EAT_NONE;
	}, { data => { invitedHook => \$invitedHook, deniedHook => \$deniedHook } });

	Xchat::command("msg ChanServ invite $channel");

	return Xchat::EAT_XCHAT;
}, { priority => Xchat::PRI_HIGHEST });
