extends Spatial


export(NodePath) var ui_win


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_player_collision():
	get_node(ui_win).set_visible(true)
	get_tree().get_root().get_child(0).win()
