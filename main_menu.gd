extends Node2D


func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var highscore = config.get_value("general","highscore",0)
	get_node("high_score").set_text(str(highscore))

func _on_play_pressed():
	get_tree().change_scene("res://main.tscn")
