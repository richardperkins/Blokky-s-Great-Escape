extends Spatial

export(NodePath) var _player
export(NodePath) var _tick_manager
export(NodePath) var _grid_map
export(String) var next_level
export(AudioStream) var sfx_win
export(AudioStream) var sfx_lose
export(AudioStream) var sfx_bgm

var player
var tick_manager
var grid_map
enum state {INIT, IDLE, PLAY, PAUSE, RESET}

var coins = 0
var removed_coins = []


var current_state = state.INIT
var level_dir = "res://scenes/"

func _ready():
	current_state = state.INIT
	player = get_node(_player)
	tick_manager = get_node(_tick_manager)
	grid_map = get_node(_grid_map)

func _process(_delta):
	if current_state == state.INIT:
		pass
	if current_state == state.IDLE:
		$"Tick Manager/CommandBlocks".set_enabled(false)
		pass
	if current_state == state.PLAY:
		pass
	if current_state == state.PAUSE:
		
		#current_state = state.IDLE
		pass
	if current_state == state.RESET:
		print("RESETTING")
		$"UI/Tick Play Controls/Stop Button".set_button_enabled(false)
		$"UI/Tick Play Controls/Play Button".reset()
		tick_manager.tick_reset()
		player.reset()
		reset()
		current_state = state.INIT
		pass
	
	# Update current tick in UI
	if tick_manager.current_tick >= 0:
		$"UI/Tick Play Controls/Current Tick".text = str(tick_manager.current_tick)
	else:
		$"UI/Tick Play Controls/Current Tick".text = ""

func play():
	$"UI/Tick Play Controls/Stop Button".set_button_enabled(true)
	$"Tick Manager/CommandBlocks".set_enabled(false)
	tick_manager.tick_play()
	current_state = state.PLAY
func pause():
	tick_manager.tick_pause()
	current_state = state.PAUSE
func stop():
	current_state = state.RESET

func get_coin(coin):
	removed_coins = [[coin, coin.get_parent()]]
	coin.get_parent().remove_child(coin)
	print("Coin get!")
	coins += 1

func die():
	$"Scene Settings/AudioStreamPlayer3D".stream = sfx_lose
	$"Scene Settings/AudioStreamPlayer3D".play()
	$UI/Lose.set_visible(true)
	pause()

func reset():
	$"Scene Settings/AudioStreamPlayer3D".stream = sfx_bgm
	$"Scene Settings/AudioStreamPlayer3D".play()
	
	for coin in removed_coins:
		coin[1].add_child(coin[0])
	current_state = state.RESET

func do_next_level():
	get_tree().change_scene(level_dir + next_level)
	pass

func win():
	$"Scene Settings/AudioStreamPlayer3D".stream = sfx_win
	$"Scene Settings/AudioStreamPlayer3D".play()
	pause()
	current_state = state.PAUSE

func retry():
	tick_manager.tick_pause()
	$UI/Lose.set_visible(false)
	reset()
	current_state = state.RESET
	pass # Replace with function body.
