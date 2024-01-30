extends Area3D

signal apple_eaten

func _on_body_entered(_body):
	name = "TempArea"
	queue_free()
	apple_eaten.emit()
