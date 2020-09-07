extends "Tickable.gd"


export(bool) var _enabled = false
var enabled

func _ready():
	enabled = _enabled

func set_enabled(enable):
	if enable and not enabled:
		$Circle001/AnimationPlayer.play("spring_up")
	if not enable and enabled:
		$Circle001/AnimationPlayer.play("reset")
	enabled = enable

func is_enabled():
	return enabled

func toggle():
	set_enabled(not enabled)

func tick_reset():
	print("Resetting")
	set_enabled(_enabled)
	current_tick = 0

func on_player_collision():
	if enabled:
		get_tree().get_root().get_child(0).die()
