use strict;

use XML::Simple;

Xchat::register("NowPlaying", "1.0");
Xchat::print("NowPlaying script loaded\n");

my $xml = new XML::Simple(SuppressEmpty => '');
my $xmlFile = (-d '/mnt') ? '/mnt/WD20EARX/now_playing.xml' : 'F:\now_playing.xml';

Xchat::hook_command('np', sub {
	my $data = $xml->XMLin($xmlFile);
	my $message = '';
	if (exists $data->{audio}) {
		if ($data->{name}) {
			$message = 'listening to';
			if ($data->{audio}->{disc_number}) {
				if ($data->{audio}->{track_number}) {
					$message = $message . sprintf(' %01d-%02d', $data->{audio}->{disc_number}, $data->{audio}->{track_number});
				}
				else {
					$message = $message . sprintf(' %01d-?', $data->{audio}->{disc_number});
				}
			}
			elsif ($data->{audio}->{track_number}) {
				$message = $message . sprintf(' %02d', $data->{audio}->{track_number});
			}
			$message = $message . " $data->{name}";
			if ($data->{audio}->{album_title}) {
				$message = $message . " ($data->{audio}->{album_title})";
			}
			if ($data->{audio}->{artist}) {
				$message = $message . " by $data->{audio}->{artist}";
			}
			elsif ($data->{audio}->{album_artist}) {
				$message = $message . " by $data->{audio}->{album_artist}";
			}
		}
	}
	elsif (exists $data->{other}) {
		if ($data->{other}->{source_url}) {
			$message = "playing $data->{other}->{source_url}";
		}
	}
	if ($message) {
		Xchat::command("me is $message");
	}
	else {
		Xchat::print("Error in $xmlFile");
	}
	return Xchat::EAT_ALL;
});