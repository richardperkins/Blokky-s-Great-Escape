extends ToolButton

export(int) var block_type

func _ready():
	connect("pressed", self, "select")

func select():
	get_node("../../..").add_block(block_type)
