extends Sprite2D

func _ready() -> void:
	var background: Vector2
	
	if Global.data.word_mode:
		background = Global.to_texture(Element.BACKGROUND_WORD)
	else:
		background = Global.to_texture(Element.BACKGROUND_BALL)
		
	region_rect.position = background * Global.TILE_SIZE
