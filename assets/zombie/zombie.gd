extends Area2D

onready var check_mid = get_node("check_mid")
onready var check_down = get_node("check_down")
var dead = false


func _ready():
	set_fixed_process(true)
	get_node("sprites").set_flip_h(true)


func _fixed_process(delta):
	set_pos(get_pos() + Vector2(-5,0))
	if not check_down.is_colliding():
		set_pos(get_pos() + Vector2(0,8))
	if check_mid.is_colliding():
		if check_mid.get_collider().is_in_group("tile"):
			queue_free()


func _on_get_player_body_enter( body ):
	if body.get_name() == "knight" and not dead:
		if body.get_node("sprites/AnimationPlayer").get_current_animation() == "attack":
			get_node("/root/main").add_points(5,get_pos())
			die()
		else:
			if not body.shield:
				body.damaged()


func die():
	dead = true
	get_node("sprites/AnimationPlayer").play("dead")


func _on_AnimationPlayer_finished():
	if get_node("sprites/AnimationPlayer").get_current_animation() == "dead":
		queue_free()