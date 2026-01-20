extends AnimationPlayer

func _on_root_selected_element(_data: GameData, _pos: Vector2i) -> void:
	stop(false)
	play("element_select")

func _on_root_selection_canceled(_data: GameData) -> void:
	play("RESET")
