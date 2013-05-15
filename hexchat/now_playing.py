import hexchat
import os
import xml.etree.ElementTree as ET

__module_name__ = 'NowPlaying'
__module_version__ = '1.0'
__module_description__ = ''

hexchat.prnt('NowPlaying script loaded')

xml_file = r'/mnt/WD20EARX/now_playing.xml' if os.path.isdir('/mnt') else r'F:\now_playing.xml'

def nowplaying_callback(word, word_eol, user_data):
	try:
		data = ET.parse(xml_file).getroot()
		
		message = ''
		
		audio = data.find('audio')
		if audio is not None:
			for name in data.findall('name'):
				message = 'listening to'
				
				disc_number = get_child_int_value(audio, 'disc_number')
				total_discs = get_child_int_value(audio, 'total_discs')
				track_number = get_child_int_value(audio, 'track_number')
				
				if disc_number is not None and total_discs is not None and total_discs > 1:
					if track_number is not None:
						message += ' {0:01d}-{1:02d}'.format(disc_number, track_number)
					else:
						message += ' {0:01d}-?'.format(disc_number)
				
				elif track_number is not None:
					message += ' {0:02d}'.format(track_number)
				
				message += ' {0}'.format(name.text)
				
				for album_title in audio.findall('album_title'):
					message += ' ({0})'.format(album_title.text)
					break
				
				artist = audio.find('artist')
				if artist is not None:
					message += ' by {0}'.format(artist.text)
				else:
					for album_artist in audio.findall('album_artist'):
						message += ' {0}'.format(album_artist.text)
						break
				
				break
		
		else:
			for source_url in (other.findall('source_url') for other in data.findall('other')):
				message = 'playing {0}'.format(source_url)
				break
	
	except (FileNotFoundError, ET.ParseError):
		pass
	
	if message:
		hexchat.command('me is {0}'.format(message))
	else:
		hexchat.prnt('Error in {0}'.format(xml_file))
	
	return hexchat.EAT_ALL

def get_child_int_value(node, child_name):
	for child in node.findall(child_name):
		if child.text:
			return int(child.text)
		else:
			return None
	
	return None

hexchat.hook_command('np', nowplaying_callback)
