extends AnimationPlayer

func _on_element_select(_pos: Vector2i) -> void:
	play("element_select")

func _on_element_cancel() -> void:
	stop(false)
	play("RESET")

func _on_target_select(_pos: Vector2i, _path: PackedVector2Array) -> void:
	play("moving")
