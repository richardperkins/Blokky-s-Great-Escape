extends GridMap

var floors = [0,1,2,3]
var traps = [4]
var switches = [5]

func get_cell_id(vec):
	return get_cell_item(round(vec.x), round(vec.y-1), round(vec.z))

func cell_is_floor (cell_id):
	return get_cell_id(cell_id) != -1

func cell_is_trap (cell_id):
	return get_cell_id(cell_id) in traps

func cell_is_switch (cell_id):
	return get_cell_id(cell_id) in switches
	
func get_cell_name (cell):
	if cell == -1:
		return "None"
	return mesh_library.get_item_name(cell)
