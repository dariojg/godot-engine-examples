extends Area2D

signal hit
# export keyword allows us to set its value in the Inspector. 
# This can be handy for values that you want to be able to adjust just like a node’s built-in properties.
# if we change value in the inspector, it will override value written in this variable
export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2() # setting the velocity to (0, 0)

	#  Check for input.	
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
		$AnimatedSprite.play()  # $ return the node at the relative path form current node is the same as get_node("AnimatedSprite").play().
	else:
		$AnimatedSprite.stop()
		
	# Move in the given direction.	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)  # clamp() to prevent it from leaving the screen
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	# Play the appropriate animation.
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
		
func _on_Player_body_entered(body):
	hide()  # The player dissapears afte being hit
	emit_signal("hit")
	$CollisionShape2D.call_deferred("set_disabled", true)  # call_defferred() wait to finish running the code (or callback) to prevent it from crashing
