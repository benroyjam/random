use strict;
use utf8;

use List::Util qw[shuffle min];
use String::Util ':all';

Xchat::register("Choose", "1.0");
Xchat::print("Choose script loaded\n");

my $choices = { CHOOSE => 0, ORDER => 1, OTHER => 2 };
my @channels = ( '#commie-subs', '#commie-staff', '#arnavion', '#vodka-subs', '#sage', '#Gundam' );
my @otherBots = ( 'Belfiore', 'Yotsugi' );

sub chooseHandler {
	my $result = Xchat::EAT_NONE;
	my $channel = Xchat::get_info('channel');

	if (grep(/^$channel$/i, @channels) && !grep { Xchat::user_info($_) } @otherBots) {
		my $choice = $choices->{OTHER};
		my $user;
		my $input;
		if ($_[0][1] =~ /^\.(?:(?:c(?:hoose)?)|(?:erande)|(?:選んで)|(?:選ぶがよい)) (.+)$/) {
			$choice = $choices->{CHOOSE};
			$user = $_[0][0];
			$input = $1;
		}
		elsif ($_[0][0] eq 'CS|Minecraft' && $_[0][1] =~ /^<([^>]*)> .choose (.+)$/) {
			$choice = $choices->{CHOOSE};
			$user = $1;
			$input = $2;
		}
		elsif ($_[0][1] =~ /^[.!]o(?:rder)? (.+)$/) {
			$choice = $choices->{ORDER};
			$user = $_[0][0];
			$input = $1;
		}
		if (($choice == $choices->{CHOOSE}) || ($choice == $choices->{ORDER})) {
			Xchat::emit_print($_[1], $_[0][0], $_[0][1], $_[0][2], $_[0][3]);
			my @choices = grep { length $_ } map { trim($_) } split(/,/, $input);
			if ($#choices > -1) {
				if ($#choices == 0) {
					@choices = grep { length $_ } map { trim($_) } split(/ /, $choices[0]);
				}

				my $response;
				if ($choice == $choices->{CHOOSE} && join('', @choices) =~ /^(-?\d+(\.\d+)?)-(-?\d+(\.\d+)?)$/) {
					if ($3 - $1 != 0) {
						if ($2 || $4) {
							$response = $1 + rand($3 - $1);
						}
						else {
							my ($first, $second) = sort($1, $3);
							$response = $first + int(rand($second - $first + 1));
						}
					}
					else {
						$response = $1;
					}
				}
				elsif ($choice == $choices->{ORDER} && join('', @choices) =~ /^(-?\d+)-(-?\d+)$/) {
					my ($first, $second) = sort($1, $2);
					$second = min($second, $first + 40 - 1);
					@choices = $first..$second;
					$response = join(', ', shuffle(@choices));
				}
				elsif ($#choices > -1) {
					if ($choice == $choices->{CHOOSE}) {
						$response = $choices[int(rand($#choices + 1))];
					}
					elsif ($choice == $choices->{ORDER}) {
						$response = join(', ', shuffle(@choices));
					}
				}

				Xchat::command("say $user: $response");
			}
			$result = Xchat::EAT_ALL;
		}
	}

	return $result;
}

Xchat::hook_print('Channel Message', \&chooseHandler, { data => 'Channel Message' });
Xchat::hook_print('Channel Msg Hilight', \&chooseHandler, { data => 'Channel Msg Hilight' });
Xchat::hook_print('Your Message', \&chooseHandler, { data => 'Your Message' });
