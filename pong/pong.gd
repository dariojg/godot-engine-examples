extends Node2D

var SCREEN_SIZE
var PAL_SIZE # Size of Pallete
var BALL_SPEED = 80 # in pixels/second
var PAL_SPEED = 100 # in pixels/second 
var direction = Vector2(-1, 0)

var r_score = 0
var l_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SCREEN_SIZE = get_viewport_rect().size
	PAL_SIZE = get_node("LeftPalllete").get_texture().get_size()
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ball_position = get_node("Ball").position
	var left_pal = Rect2(get_node("LeftPalllete").position - PAL_SIZE/2, PAL_SIZE)
	var right_pal = Rect2(get_node("RightPallete").position - PAL_SIZE/2, PAL_SIZE)
	
	ball_position += direction * BALL_SPEED * delta
	
	if ( (ball_position.y < 0 and direction.y < 0) or (ball_position.y > SCREEN_SIZE.y and direction.y > 0)):
		direction.y = -direction.y
		
	if ( (left_pal.has_point(ball_position) and direction.x < 0) 
	or (right_pal.has_point(ball_position) and direction.x > 0) ):
		direction.x = -direction.x
		BALL_SPEED *= 1.1
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
	
	if (ball_position.x < 0):
		ball_position =SCREEN_SIZE * 0.5 # The ball show in center of screenla bola va al centro de la pantalla
		BALL_SPEED = 80 # reset velocity
		direction = Vector2 (-1, 0) # original direction
		r_score += 1
		get_node("RightScore").text = str(r_score)
		
	if (ball_position.x > SCREEN_SIZE.x):
		ball_position =SCREEN_SIZE * 0.5 # The ball show in center of screenla bola va al centro de la pantalla
		BALL_SPEED = 80 # reset velocity
		direction = Vector2 (-1, 0) # original direction
		l_score += 1
		get_node("LeftScore").text = str(l_score)

	get_node("Ball").position = ball_position

	var left_position = get_node("LeftPalllete").position
	print(left_position)
	if (left_position.y > 0 and Input.is_action_pressed("l_move_up")):
		left_position.y += -PAL_SPEED * delta
	if (left_position.y < SCREEN_SIZE.y and Input.is_action_pressed("l_move_down")):
		left_position.y += PAL_SPEED * delta

	get_node("LeftPalllete").position = left_position
	
	var right_position = get_node("RightPallete").position
	if (right_position.y > 0 and Input.is_action_pressed("r_move_up")):
		right_position.y += -PAL_SPEED * delta
	if (right_position.y < SCREEN_SIZE.y and Input.is_action_pressed("r_move_down")):
		right_position.y += PAL_SPEED * delta

	get_node("RightPallete").position = right_position

	