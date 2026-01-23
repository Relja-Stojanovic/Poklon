extends TileMapLayer

func _ready() -> void:
	var background
	
	if Global.data.word_mode:
		background = Global.to_texture(Element.BACKGROUND_WORD)
	else:
		background = Global.to_texture(Element.BACKGROUND_BALL)
	
	for x in range(Global.data.size):
		for y in range(Global.data.size):
			set_cell(Vector2i(x, y), 0, background)
