extends CanvasLayer

var paused_flag = false
var gameover_flag = false
var half_width
var half_height
var origo_point

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverSign.hide()
	$PauseSign.hide()
	$HelpButton.hide()
	$AboutButton.hide()
	$HelpSign.hide()
	$AboutSign.hide()
	var temp_size = get_viewport().size
	half_width = temp_size[0] / 2
	half_height = temp_size[1] / 2
	origo_point = Vector2(half_width, half_height)
	$Crosshair23.position = origo_point
	$ArrowPivot.position = origo_point


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("restart_or_pause"):
		if gameover_flag:
			get_tree().paused = false
			get_tree().reload_current_scene()
		elif paused_flag:
			$PauseSign.hide()
			$HelpButton.hide()
			$AboutButton.hide()
			$HelpSign.hide()
			$AboutSign.hide()
			get_tree().paused = false
			paused_flag = false
		else:
			paused_flag = true
			pause()

	pass

func display_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func display_body_length(length):
	$BodyLabel.text = "Body length: " + length

func game_over():
	gameover_flag = true
	$HelpButton.show()
	$AboutButton.show()
	$GameOverSign.show()


func pause():
	$HelpButton.show()
	$AboutButton.show()
	$PauseSign.show()


func rotate_arrow(angle):
	if angle < 0:
		angle += 2 * PI
	elif angle > 2 * PI:
		angle -= 2 * PI

	$ArrowPivot.rotation = angle

	if angle > PI:
		angle -= PI
	if angle > PI/2:
		angle = PI - angle

	if angle <= 1.05:
		var temp_added = half_height / cos(angle)
		$ArrowPivot/AppleArrow.position = Vector2(-10, -temp_added)
	else:
		var temp_added = (half_width) / sin(angle)
		$ArrowPivot/AppleArrow.position = Vector2(-10,-temp_added)

func hide_arrow():
	$ArrowPivot.hide()

func show_arrow():
	$ArrowPivot.show()

func display_health(health):
	if health == 2:
		$Heart3.texture = load("res://resources/heart_empty.png")
	elif health == 1:
		$Heart2.texture = load("res://resources/heart_empty.png")
	else:
		$Heart1.texture = load("res://resources/heart_empty.png")


func _on_help_button_pressed():
	if $HelpSign.visible:
		$HelpSign.hide()
		if paused_flag:
			$PauseSign.show()
		else:
			$GameOverSign.show()
		return
	elif $AboutSign.visible:
		$AboutSign.hide()
	else:
		$PauseSign.hide()
		$GameOverSign.hide()

	$HelpSign.show()


func _on_about_button_pressed():
	if $AboutSign.visible:
		$AboutSign.hide()
		if paused_flag:
			$PauseSign.show()
		else:
			$GameOverSign.show()
		return
	elif $HelpSign.visible:
		$HelpSign.hide()
	else:
		$PauseSign.hide()
		$GameOverSign.hide()

	$AboutSign.show()
