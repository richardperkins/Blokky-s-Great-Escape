extends ToolButton

export(Texture) var icon_play
export(Texture) var icon_paused
var is_playing = false

func _ready():
	is_playing = false
	connect("pressed", self, "toggle_play")

func toggle_play():
	is_playing = not is_playing
	if is_playing:
		self.icon = icon_paused
		get_tree().get_root().get_child(0).play()
	else:
		self.icon = icon_play
		get_tree().get_root().get_child(0).pause()

func reset():
	icon = icon_play
	is_playing = false
