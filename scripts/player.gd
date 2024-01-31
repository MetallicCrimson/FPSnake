extends RigidBody3D


const BASE_SPEED = 30
var acc_speed = 80
var speed = 30
var rotate_speed = 3
var body_array = []
var plus_points = 99
var health = 3
var apple = null
var movement = Vector2.ZERO

signal next_body
signal delete_body
signal game_over
signal hit

func _physics_process(delta):
	var input_dir
	
	if Input.is_action_pressed("accelerate") and speed == BASE_SPEED:
		speed = acc_speed
		$NextBodyArea/CollisionShape3D.scale = Vector3(10,10,10)
	elif speed == acc_speed:
		speed = BASE_SPEED
		$NextBodyArea/CollisionShape3D.scale = Vector3(1,1,1)
	
	if movement != Vector2.ZERO:
		input_dir = movement
	else:
		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if input_dir == Vector2.ZERO:
		input_dir = Input.get_last_mouse_velocity() * .0008
		
	print(input_dir)
		
	if abs(input_dir.x):
		rotate_object_local(Vector3(0,1,0), -(input_dir.x * delta * rotate_speed))
	if abs(input_dir.y):
		rotate_object_local(Vector3(1,0,0), -(input_dir.y * delta * rotate_speed))

	move_and_collide(-transform.basis.z * delta * speed)


func _on_next_body_area_area_exited(area):
	if area == body_array[0]:
		next_body.emit()


func _on_player_area_area_entered(area):
	if not $IframeTimer.is_stopped():
		return
	
	if area != apple and body_array.size() > 1 and area != body_array[0] and area.name != "TempArea": # wow. most likely it'll be refactored
		if health == 0:
			game_over.emit()
		else:
			health -= 1
			hit.emit(health)
			$IframeTimer.start()

func _on_player_area_body_entered(_body):
	pass
	
func is_overlapping_something(vect):
	return vect.distance_to(position) < 4 or body_array.any(func(temp_pos): return vect.distance_to(temp_pos.position) < 4)


func _on_body_timer_timeout():
	pass
	#next_body.emit()


func _on_hud_acc_changed(speed):
	print("New acc: ", speed)
	acc_speed = speed
