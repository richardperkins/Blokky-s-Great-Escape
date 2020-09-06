extends Control

export (NodePath) onready var _level_manager
var level_manager
export(Array,PackedScene) var command_block_prefabs
export(PackedScene) var command_block_prefab
export(Array, Texture) var icon_blocks
onready var player
var command_block_container
var command_blocks = []
var current_command

var enabled = true

var commands = [ "rotate_ccw", "move", null, "rotate_cw"]

func _ready():
	# WARNING: HaXxY codez :(
	level_manager = get_node(_level_manager)
	player = level_manager.player
	command_block_container = $"Command Blocks/Blocks/Scroll View/Command Block"

func process_player():
	if level_manager.player.colliding_with:
		level_manager.player.colliding_with.get_node("..").call("on_player_collision")
	if not level_manager.player.is_on_ground():
		level_manager.die()
	pass

# Tick called by tick manager
func tick ():
	process_player()
	var command_block = command_block_container.get_block(level_manager.tick_manager.current_tick)
	if command_block:
		command_block.grab_focus()
		current_command = command_block.type
		if commands[current_command]:
			level_manager.player.call(commands[current_command])
	else:
		get_tree().get_root().get_child(0).get_node("UI/Tick Play Controls/Play Button").grab_focus()
		
func tick_reset():
	pass

func set_enabled(val):
	enabled = val
	get_node("Command Blocks/Blocks/Scroll View/Command Block").set_enabled(val)
	for control in get_node("Command Blocks/Block_controls").get_children():
		if control is Button:
			control.disabled = val
	
	


# Add block to queue
func add_block(type):
	command_block_container.add_child(command_block_prefab.instance())
	var new_node = command_block_container.get_child(command_block_container.get_child_count()-1)
	new_node.get_node("Icon").texture = icon_blocks[type]
	new_node.type = type
	pass
