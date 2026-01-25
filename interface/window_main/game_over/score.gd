extends Label

func _on_window_visibility_changed() -> void:
	text = "Finalni poeni: " + ScoreService.to_str(Global.final_score)
