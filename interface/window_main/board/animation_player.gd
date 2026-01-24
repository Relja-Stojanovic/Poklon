extends AnimationPlayer

func _on_element_select(_pos: Vector2i) -> void:
	stop(false)
	play("element_select")

func _on_element_cancel() -> void:
	stop(false)
	play("RESET")
