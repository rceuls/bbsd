extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
export var is_hostile = false

func _ready():
	pass 

func _on_Visibility_screen_exited():
	queue_free()

func _on_positive():
	queue_free();
	return "coffee"