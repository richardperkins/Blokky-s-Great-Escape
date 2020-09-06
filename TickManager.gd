extends Node

var enabled = false
var tick_speed = 1
var t = 0
var current_tick = -1

# NOTE: Tickable objects are children of this node
var tickables = []

func _init():
	tickables = get_children()

func tick_play():
	enabled = true

func tick_pause():
	enabled = false

func tick_reset():
	enabled = false
	t = 0
	current_tick = -1
	for tickable_object in get_children():
		tickable_object.tick_reset()
	# TODO: Call all movables to reset

func tick():
	current_tick += 1
	for tickable_object in get_children():
		tickable_object.call("tick")
	pass

func _process(delta):
	if enabled:
		t += delta
		if t >= tick_speed:
			t = 0
			tick()
		pass
