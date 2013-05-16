import hexchat

__module_name__ = 'Highlight Logger'
__module_version__ = '1.0'
__module_description__ = ''

hexchat.prnt('Highlight Logger loaded')

tab_name = '(Highlights)'

def highlight_callback(word, word_eol, user_data):
	word = [(word[i] if len(word) > i else '') for i in range(4)]
	
	channel = hexchat.get_info('channel')
	highlight_context = hexchat.find_context(channel=tab_name)
	
	if user_data == 'Channel Msg Hilight':
		highlight_context.prnt('{0}\t\00320<{4}{3}{1}> {2}'.format(channel, word[0], word[1], word[2], word[3]))
	elif user_data == 'Channel Action Hilight':
		highlight_context.prnt('{0}\t\00320{4}{3}{1} {2}'.format(channel, word[0], word[1], word[2], word[3]))
	
	return hexchat.EAT_NONE

hexchat.hook_print('Channel Msg Hilight', highlight_callback, 'Channel Msg Hilight')
hexchat.hook_print('Channel Action Hilight', highlight_callback, 'Channel Action Hilight')

hexchat.command('query {0}'.format(tab_name))
