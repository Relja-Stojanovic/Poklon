class_name WordGameStrategy extends GameStrategy

func gen_preview_element() -> int:
	return randi() % 30 + Element.LETTER_A
