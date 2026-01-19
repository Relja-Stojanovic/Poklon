extends AnimationPlayer

func _on_root_selected_element(_data: GameData, _pos: Vector2i) -> void:
	play("element_select")
