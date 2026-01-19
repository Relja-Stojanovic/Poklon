extends Sprite2D

func _ready() -> void:
	var background
	
	if Global.data.word_mode:
		background = Global.to_texture(Element.BACKGROUND_WORD)
	else:
		background = Global.to_texture(Element.BACKGROUND_BALL)
