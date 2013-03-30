use strict;

Xchat::register("Rainbows", "1.0");
Xchat::print("Rainbows script loaded\n");

my @colors = ('04', '08', '09', '12', '13');
my @backColors = ('09', '12', '13', '04', '08');
my $currentColor = -1;
my $fabHook;

sub fabHandler {
	Xchat::command(
		'say ' .
		join(' ', map { join('',
			map {
				/^(?:(?:\x03\d\d?(?:,\d\d?)?))/ ?
					$_ :
					"\x03" . $colors[$currentColor = (($currentColor + 1) % scalar(@colors))] . $_;
			} grep { $_ ne '' } split(/((?:\x03\d\d?(?:,\d\d?)?)|.)/, $_)
		)} split(/ /, $_[1][1]))
	);
	return Xchat::EAT_ALL;
}

sub fab2Handler {
	Xchat::command('say ' . join('',
		map {
			$currentColor = (($currentColor + 1) % scalar(@colors));
			my $result =
				/^(?:(?:\x03\d\d?(?:,\d\d?)?))/ ?
					$_ :
					"\x03" . $colors[$currentColor] . ',' . $backColors[$currentColor] . $_;
			$result;
		} grep { $_ ne '' } split(/((?:\x03\d\d?(?:,\d\d?)?)|.)/, $_[1][1])
	));
	return Xchat::EAT_ALL;
}

sub spoilerHandler {
	Xchat::command('say ' . join('',
		map {
			/^(?:(?:\x03\d\d?(?:,\d\d?)?))/ ?
				$_ :
				join($colors[$currentColor = (($currentColor + 1) % scalar(@colors))], ("\x03", ',', $_))
		} grep { $_ ne '' } split(/((?:\x03\d\d?(?:,\d\d?)?)|.)/, $_[1][1])
	));
	return Xchat::EAT_ALL;
}

sub enfabHandler {
	if ($fabHook == undef) {
		$fabHook = Xchat::hook_command('', sub {
			Xchat::command("fab $_[1][0]");
			return Xchat::EAT_ALL;
		});
		Xchat::print('Fabulous mode on');
	}
	return Xchat::EAT_ALL;
}

sub defabHandler {
	Xchat::unhook($fabHook);
	$fabHook = undef;
	Xchat::print('Fabulous mode off');
	return Xchat::EAT_ALL;
}

Xchat::hook_command('fab', \&fabHandler);
Xchat::hook_command('fab2', \&fab2Handler);
Xchat::hook_command('spoiler', \&spoilerHandler);
Xchat::hook_command('enfab', \&enfabHandler);
Xchat::hook_command('defab', \&defabHandler);
