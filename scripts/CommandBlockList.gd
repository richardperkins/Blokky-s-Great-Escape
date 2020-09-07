extends VBoxContainer


var selected_index

var selected_block
var enabled = true

func set_enabled(val):
	enabled = val
	for block in get_children():
		block.disabled = enabled

func _ready():
	pass

func select(block):
	selected_block = block

func remove():
	remove_child(selected_block)
	selected_block = null

func move_up():
	if selected_block:
		move_child(selected_block, selected_block.get_index()-1)
		update_all_tick_numbers()
	pass

func update_all_tick_numbers():
	for block in get_children():
		block.update_tick_number()


func move_down():
	if selected_block:
		move_child(selected_block, selected_block.get_index()+1)
		update_all_tick_numbers()
	pass


func _on_Up_pressed():
	pass # Replace with function body.

func get_block(index):
	if index in range(get_child_count()):
		return get_child(index)



func clear():
	while get_child_count() > 0:
		remove_child(get_child(0))
