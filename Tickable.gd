extends Spatial
export(Array, String) var command_block_queue = []
var current_tick = 0
var current_command

func tick():
	current_tick += 1
	# Wrap tick function to beginning
	if current_tick >= len(command_block_queue):
		current_tick = 0	
	if len(command_block_queue) > 0:
		# Call method if applicable to current tick
		current_command = get_current_command()
		if current_command:
			call(current_command)

func tick_reset():
	current_tick = 0
	pass

func get_current_command():
	return command_block_queue[current_tick]
