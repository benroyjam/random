use strict;

Xchat::register("GreenText", "1.0");
Xchat::print("GreenText script loaded\n");

sub greenTextHandler {
	my $result = Xchat::EAT_NONE;

	if ($_[0][1] =~ /^>(.+)$/) {
		Xchat::emit_print($_[1], $_[0][0], "\x03" . '09' . $_[0][1], $_[0][2], $_[0][3]);
		$result = Xchat::EAT_ALL;
	}

	return $result;
}

Xchat::hook_print('Channel Message', \&greenTextHandler, { data => 'Channel Message' });
Xchat::hook_print('Your Message', \&greenTextHandler, { data => 'Your Message' });
