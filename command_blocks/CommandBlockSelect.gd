extends Button

export(int) var type

func _ready():
	connect("pressed", get_node(".."), "select", [self])
	update_tick_number()

func update_tick_number():
	$Tick.text = str(get_index())
