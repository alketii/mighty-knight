extends Area2D

func _on_spikes_body_enter( body ):
	if body.get_name() == "knight":
		body.damaged()