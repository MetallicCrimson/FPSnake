extends Node

@export var apple_scene : PackedScene
@export var snake_body_scene : PackedScene
var score = 0
var added_length = 100
var apple = null
var is_apple_on_screen = false
var apple_just_rendered = false
var window_width
var window_height
var origo_point


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var temp_size = get_tree().get_root().size
	window_width = temp_size[0]
	window_height = temp_size[1]
	origo_point = Vector2(window_width/2, window_height/2)
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("restart_or_pause"):
		get_tree().paused = true
		
	#temp_position = 
	#is_apple_on_screen = apple.position.x >= 0 and apple.position.x <= window_width and apple.position.y >= 0 and apple.position.y <= window_height and not get_viewport().get_camera_3d().is_position_behind(apple.position)
		
		
	if true: #not is_apple_on_screen and not apple_just_rendered:
		
		
		var temp_pos = $Player/PlayerCamera.unproject_position(apple.position)
		var x1 = origo_point[0]
		var y1 = origo_point[1]
		var x2 = temp_pos[0]
		var y2 = temp_pos[1]
		
		if x2 >= 0 and x2 <= window_width and y2 >= 0 and y2 <= window_height and not get_viewport().get_camera_3d().is_position_behind(apple.position):
			$HUD.hide_arrow()
			return
		else:
			$HUD.show_arrow()
		
		var temp_angle = atan((y2 - y1) / (x2 - x1))
		var temp_angle2 = temp_angle
		
		if x2 > x1:
			temp_angle2 += PI/2
		else:
			temp_angle2 -= PI/2
		
		if get_viewport().get_camera_3d().is_position_behind(apple.position):
			temp_angle2 -= PI
			
		$HUD.rotate_arrow(temp_angle2)
	
	apple_just_rendered = false

func start_game():
	add_new_apple()

func add_point():
	add_new_apple()
	score += 1
	$Player.plus_points += added_length
	added_length += 1
	$HUD.display_score(score)

func add_new_apple():
	var vect = get_apple_pos()
	while $Player.is_overlapping_something(vect):
		vect = get_apple_pos()
	
	apple = apple_scene.instantiate()
	$Player.apple = apple
	apple.position = vect
	apple.apple_eaten.connect(add_point)
	apple_just_rendered = true
	add_child(apple)
	

func get_apple_pos():
	var x = randi_range(-185,185)
	var y = randi_range(15, 385)
	var z = randi_range(-185,185)
	return Vector3(x,y,z)


func _on_player_next_body():
	if $Player.plus_points > 0:
		$Player.plus_points -= 1
		var snake_body = snake_body_scene.instantiate()
		snake_body.position = $Player.position
		$Player.body_array.push_front(snake_body)
		add_child.call_deferred(snake_body)
		$HUD.display_body_length(str($Player.body_array.size()))
	elif $Player.body_array:
	
		var temp_body = $Player.body_array[-1]
		temp_body.position = $Player.position
		$Player.body_array.pop_back()
		$Player.body_array.push_front(temp_body)


func _on_player_ready():
	var snake_body = snake_body_scene.instantiate()
	snake_body.position = $Player.position
	$Player.body_array.push_front(snake_body)
	add_child.call_deferred(snake_body)


func _on_player_delete_body():
	if false:
		$Player.body_array[-1].queue_free()
		$Player.body_array.pop_back()


func _on_player_game_over():
	$HUD.game_over()
	get_tree().paused = true


func _on_player_hit(health):
	$HUD.display_health(health)


func _on_ee_body_entered(_body):
	$HUD.game_over()
	get_tree().paused = true
