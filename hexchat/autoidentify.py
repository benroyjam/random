import hexchat

__module_name__ = 'AutoIdentify'
__module_version__ = '1.0'
__module_description__ = ''

hexchat.prnt('AutoIdentify script loaded')

nicks = ('Arnavion', 'AtashiCon',)
ghosting_nick = 'Arnavion3'

def autoidentify_callback(word, word_eol, user_data):
	result = hexchat.EAT_NONE
	
	nickname = word[3]
	password = hexchat.get_info('nickserv')
	
	if nickname in nicks and password:
		if word[2] != ghosting_nick:
			hexchat.command('nick {0}'.format(ghosting_nick))
		
		hexchat.command('ghost nick {0}'.format(password))
		hexchat.command('nick {0}'.format(nickname))
		hexchat.command('identify {0}'.format(password))
		result = hexchat.EAT_XCHAT
	
	return result

hexchat.hook_server('433', autoidentify_callback, priority=hexchat.PRI_HIGHEST)
