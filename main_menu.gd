extends Node2D


func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var highscore = config.get_value("general","highscore",0)
	get_node("high_score").set_text(str(highscore))

func _on_play_button_down():
	get_tree().change_scene("res://main.tscn")


func _on_open_url_pressed():
	OS.shell_open("https://alketii.github.io/index.html")
