class_name WordGameStrategy extends GameStrategy

func gen_preview_element() -> int:
	return randi() % 30 + Element.LETTER_A

func execute_match(_data: GameData, _pos: Vector2i) -> bool:
	return false
