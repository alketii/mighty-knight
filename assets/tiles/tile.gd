extends StaticBody2D

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()