extends Area2D

onready var idle = get_node("idle").get_animation("idle").duplicate()

func _ready():
	var angle = deg2rad(randi() % 360)
	idle.track_set_key_value(0, 0, Vector2(4*cos(angle), 4*sin(angle)))
	idle.track_set_key_value(0, 1, Vector2(-4*cos(angle), -4*sin(angle)))
	idle.track_set_key_value(0, 2, Vector2(4*cos(angle), 4*sin(angle)))
	get_node("idle").add_animation("idle_bis", idle)
	get_node("idle").set_speed(rand_range(0.5, 0.75))
	get_node("idle").play("idle_bis")
	set_fixed_process(true)

func _fixed_process(delta):
	if get_pos().x - get_node("/root/main/knight").get_pos().x < 1000:
		get_node("AnimationPlayer").play("spawn")
		get_node("AnimationPlayer").connect("finished", get_node("AnimationPlayer"), "connect", ["finished", self, "queue_free"])
		get_node("AnimationPlayer").connect("finished", get_node("AnimationPlayer"), "disconnect", ["finished", self, "queue_free"])
		set_fixed_process(false)

func _on_coin_body_enter( body ):
	if body.get_name() == "knight":
		get_node("/root/main").add_points(1,get_pos())
		get_node("AnimationPlayer").play("picked")

func _on_coin_area_enter( area ):
	if area.is_in_group("tile"):
		queue_free()