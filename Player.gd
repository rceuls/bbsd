extends Area2D

export var speed = 400
var screen_size
signal hit
signal something_positive(id)

func _ready():
	screen_size	= get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right" if velocity.x > 0 else "left"
	elif velocity.y != 0:
		$AnimatedSprite.animation = "down" if velocity.y > 0 else "up"

func _on_Player_body_entered(body):
	if body.has_method("_on_positive"):
		emit_signal("something_positive", body._on_positive())
	else:
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
