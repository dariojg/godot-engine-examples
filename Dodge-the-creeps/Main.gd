extends Node

export (PackedScene) var Mob 
var score
#var mob_scene = preload("res://mob.tscn")	

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$HUD.update_score(score)
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score = 0	
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("get ready")
	$Music.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	var mob = Mob.instance()
	 # add it to  the scene the new mob.
	add_child(mob) 
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)	
