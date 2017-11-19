extends KinematicBody2D

onready var tween = get_node("Tween")
onready var label = get_node("label")

func _ready():
	var i = int(get_node("label").get_text())
	if i > 10:
		i = 10
	get_node("label").set("custom_colors/font_color", Color(1, 1.1-i*0.1, 1-i*0.1))
	set_fixed_process(true)

func _fixed_process(delta):
	move(Vector2(0,-8))

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
