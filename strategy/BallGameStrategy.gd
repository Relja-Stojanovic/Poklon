class_name BallGameStrategy extends GameStrategy

func gen_preview_element() -> int:
	return randi() % 7 + Element.BALL_RED
