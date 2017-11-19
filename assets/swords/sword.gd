extends Area2D

var emitting = true
var hit = false

var on_ground = false
var danger = true

func _ready():
	set_z(-15)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if not on_ground and not hit:
		set_pos(get_pos() + Vector2(0,10))

func _on_Area2D_body_enter( body ):
	var anim = str(randi() % 2 + 1)
	if body.get_name() == "knight" and not hit:
		if body.get_node("sprites/AnimationPlayer").get_current_animation() == "attack":
			get_node("/root/main").add_points(8, get_pos())
			body._on_attack_cooloff_timeout()
		else:
			if danger:
				body.damaged()
		get_node("AnimationPlayer").play("destroyed" + anim)
		hit = true
	elif body.get_name() == "zombie":
		hit = true
		get_node("AnimationPlayer").play("destroyed" + anim)
		body.die()
	
	elif body.is_in_group("tile"):
		on_ground = true
		get_node("AnimationPlayer").play("planted")