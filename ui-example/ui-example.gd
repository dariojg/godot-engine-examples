extends Control

var is_pressed = false

func _draw():
	
	var r = Rect2(Vector2(), rect_size)
	
	if (is_pressed):
		draw_rect(r, Color(1, 0, 0))
	else:
		draw_rect(r, Color(0, 0, 1))
		
func _input(event):
	if(event.is_pressed() and Input.is_mouse_button_pressed(BUTTON_LEFT)):
		is_pressed = !is_pressed
		update()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
