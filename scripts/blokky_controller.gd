extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var original_pos
var target_pos
var move_speed
var is_moving = false

var sleeping = false

var grid
var anim
var anim_blend = 0.2
var anim_speed = 1
var anim_walk_speed = 1.5
var animations = [
	[null, anim_speed],
	["blokky-idle", anim_speed],
	["blokky-walk", anim_walk_speed],
	["blokky_jump", anim_walk_speed],
	["blokky-death", anim_speed]
]

var t = 0
var tween_duration = 1
var tween_turn_duration = 0.5
var tween_timer = 0
var tween_var
var move_amount = Vector3(0,0,2)
var orientation = 0
var move_direction = [
	Vector3(0,0,2), #forward
	Vector3(-2,0,0),	#right
	Vector3(0,0,-2),#backward
	Vector3(2,0,0) #left
]

var reset_position
var reset_orientation

var colliding_with

# States #
# 0 - Init
# 1 - Idle
# 2 - Walking
# 3 - Rotating
# 4 - Dying
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_position = transform.origin
	reset_orientation = rotation
	original_pos = transform.origin
	grid = get_parent().get_node("GridMap")
	anim = $Armature/AnimationPlayer
	#move(Vector3(0,0,-2))
	pass # Replace with function body.

func reset():
	transform.origin = reset_position
	rotation = reset_orientation

func move ():
	tween_timer = 0
	original_pos = transform.origin
	target_pos = get_move_vec()
	is_moving = true
	set_state(2)

func rotate_cw ():
	
	orientation += 1
	if orientation == 4:
		orientation = 0
	if orientation == -1:
		orientation = 3
	original_pos = rotation_degrees
	target_pos = rotation_degrees + Vector3(0,-90,0)
	set_state(3)
	
func rotate_ccw ():
	orientation -= 1
	if orientation == 4:
		orientation = 0
	if orientation == -1:
		orientation = 3
	original_pos = rotation_degrees
	target_pos = rotation_degrees + Vector3(0,90,0)
	set_state(3)
	
func is_on_ground():
	return grid.cell_is_floor(grid.world_to_map(transform.origin))
	#var grid_map = get_parent().get_node("GridMap")
	#var cell_id = grid_map.world_to_map(transform.origin)
	#var ground_type = grid_map.get_cell_item(cell_id.x, cell_id.y, cell_id.z)
	#return ground_type != -1

func get_move_vec ():
	#return transform.origin + move_direction[orientation]
	if not grid.cell_is_floor(grid.world_to_map(transform.origin+global_transform.basis.z*2+Vector3.UP*2)):
		return transform.origin + self.global_transform.basis.z * 2
	else:
		return transform.origin

func _physics_process(_delta):
	colliding_with = $ray_forward.get_collider()
	

func set_state(new_state):
	tween_timer = 0
	if new_state != state:
		if animations[new_state][0]:
			anim.play(animations[new_state][0], anim_blend, animations[new_state][1])		
	state = new_state

func idle_state_update (_delta):
	pass

func walk_state_update (delta):
	tween_timer += delta
	transform.origin = lerp(original_pos, target_pos, tween_timer / tween_duration)
	# End tween
	if tween_timer >= tween_duration:
		transform.origin = target_pos
		is_moving = false
		# Go back to idle state
		set_state(1)
	pass
	
func rotate_state_update (delta):
	#TODO: Update state...
	tween_timer += delta
	rotation_degrees = lerp(original_pos, target_pos, tween_timer / tween_turn_duration)
	if tween_timer >= tween_turn_duration:
		rotation_degrees = target_pos
		set_state(1)
	pass
	
func die_state_update (_delta):
	#TODO: Update state...
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# State handling
	if state == 0:		# Init
		#TODO: Initialization here...
		set_state(1)
	elif state == 1:	# Idle
		idle_state_update(delta)
	elif state == 2:	# Walking
		walk_state_update(delta)
	elif state == 3:	# Jumping
		rotate_state_update(delta)
	elif state == 4:	# Dying
		die_state_update(delta)
	else:				# Default
		# NOTE Unhandled states be here!
		pass
