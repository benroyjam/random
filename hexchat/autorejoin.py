import hexchat

__module_name__ = 'AutoRejoin'
__module_version__ = '1.0'
__module_description__ = ''

hexchat.prnt('Autorejoin script loaded')

def autorejoin_callback(word, word_eol, user_data):
	hexchat.hook_timer(3000, rejoin_timer_callback, word[1])

def rejoin_timer_callback(user_data):
	hexchat.command('join {0}'.format(user_data))

hexchat.hook_print('You Kicked', autorejoin_callback)
