extends Area2D

var screensize

func _ready():
	$Tween.interpolate_property(
		$AnimatedSprite, # The node to affect
		'scale', # The property to alter
		$AnimatedSprite.scale,  # The property's starting value
		$AnimatedSprite.scale * 3,  # The property's ending value
		0.3,  # The duration (in seconds)
		Tween.TRANS_QUAD,  # The function to use
		Tween.EASE_IN_OUT  # The direction
		)
		
	$Tween.interpolate_property(
		$AnimatedSprite, 
		'modulate', 
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		0.3,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
		)


func pickup():
	monitoring = false  # ensures that the area_enter() signal won't be emmited if the player touches the coin during the tween animation
	$Tween.start()


func _on_Powerup_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(
			rand_range(0, screensize.x),
			rand_range(0, screensize.y)
		)


func _on_LifeTime_timeout():
	queue_free()
