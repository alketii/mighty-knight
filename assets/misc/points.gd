extends KinematicBody2D

onready var tween = get_node("Tween")
onready var label = get_node("label")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	move(Vector2(0,-8))

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
