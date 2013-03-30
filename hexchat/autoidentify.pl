use strict;

Xchat::register("AutoIdentify", "1.0");
Xchat::print("AutoIdentify script loaded\n");

my @nicks = ( 'Arnavion', 'Arnavion|asleep', 'Arnavion|work', 'AtashiCon', 'Pedonavion' );

Xchat::hook_server('433', sub {
	my $result = Xchat::EAT_NONE;
	my $nick = $_[0][3];
	my $pwd = Xchat::get_info('nickserv');

	if (grep(/^$nick$/, @nicks)) {
		if ($_[0][2] ne 'Arnavion3') {
			Xchat::command("nick Arnavion3");
		}
		Xchat::command("ghost $nick $pwd");
		Xchat::command("nick $nick");
		Xchat::command("identify $pwd");
		$result = Xchat::EAT_XCHAT;
	}

	return $result;
}, { priority => Xchat::PRI_HIGHEST });
