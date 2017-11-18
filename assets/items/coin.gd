extends Area2D

func _on_coin_body_enter( body ):
	if body.get_name() == "knight":
		get_node("/root/main").add_points(1,get_pos())
		get_node("AnimationPlayer").play("picked")

func _on_coin_area_enter( area ):
	if area.is_in_group("tile"):
		queue_free()
