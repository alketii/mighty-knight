extends Node2D

onready var label = get_node("label")
onready var anim = get_node("AnimationPlayer").get_animation("bump").duplicate()

func _ready():
	var i = int(get_node("label").get_text())
	if i > 10:
		i = 10
	
	anim.track_set_key_value(0, 1, Vector2((5+i)/3, (5+i)/3))
	get_node("AnimationPlayer").add_animation("bump_bis", anim)
	get_node("AnimationPlayer").play("bump_bis")
	
	get_node("label").set("custom_colors/font_color", Color(1, 1.1-i*0.1, 1-i*0.1))
	set_fixed_process(true)

func _fixed_process(delta):
	if get_pos().y > -128:
		set_pos(get_pos() + Vector2(0, -8))
	else:
		queue_free()
