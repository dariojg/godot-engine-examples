extends Node


var levels = [
	'res://levels/Level1.tscn',
	'res://levels/Level2.tscn'
	]

var current_level 
var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'
var score
var highscore = 0
var score_file = "user://higscore.txt"

func setup():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()
		
func _ready():
	setup()
	
	
func new_game():
	current_level = -1
	score = 0
	next_level()
	
	
func next_level():
	current_level += 1
	if current_level >= Global.levels.size():
		#no more levels to load
		game_over()
	else:
		get_tree().change_scene(levels[current_level])

	
func game_over():
	if score > highscore:
		highscore = score
		save_score()
	get_tree().change_scene(end_screen)


func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE) # si no existe lo cre
	f.store_string(str(highscore))
	f.close()
