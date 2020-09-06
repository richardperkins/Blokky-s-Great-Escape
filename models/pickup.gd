extends Spatial

var original_pos
var current_pos
var rotation_speed = Vector3(0,90,0) # Rotations per second, in degrees

#var bob_amount = 0.25
#var bob_speed = 4
#var t = 0

#func _init ():
#	original_pos = transform.origin
#	current_pos = Vector3(original_pos.x, original_pos.y, original_pos.z)

#func _process(delta):
#	t += delta
#	current_pos.y =  original_pos.y + sin(t * bob_speed) * bob_amount
#	transform.origin = current_pos
#	rotate(Vector3.UP, 5 * delta)


func on_player_collision():
	get_tree().get_root().get_child(0).get_coin(self)
