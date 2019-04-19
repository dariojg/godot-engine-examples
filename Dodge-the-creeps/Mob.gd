extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

var mob_types = ["walk", "swim", "fly"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]  # return a random animation
	
func _on_Visibility_screen_exited():
    queue_free()  #  The mobs delete themselves when they leave the screen
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
