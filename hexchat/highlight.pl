use strict;

Xchat::register("Highlight Logger", "1.0");
Xchat::print("Highlight Logger loaded\n");

my $tabName = '(Highlights)';

sub highlightHandler {
	my $channel = Xchat::get_info('channel');
	if ($_[1] eq 'Channel Msg Hilight') {
		Xchat::print("$channel\t\00320<$_[0][3]$_[0][2]$_[0][0]> $_[0][1]", $tabName);
	}
	elsif ($_[1] eq 'Channel Action Hilight') {
		Xchat::print("$channel\t\00320$_[0][3]$_[0][2]$_[0][0] $_[0][1]", $tabName);
	}
	return Xchat::EAT_NONE;
}

Xchat::hook_print('Channel Msg Hilight', \&highlightHandler, { data => 'Channel Msg Hilight' });
Xchat::hook_print('Channel Action Hilight', \&highlightHandler, { data => 'Channel Action Hilight' });

Xchat::command("query $tabName");
