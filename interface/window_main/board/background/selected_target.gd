extends Sprite2D

func _ready() -> void:
	var background: Vector2
	
	if Global.data.word_mode:
		background = Global.to_texture(Element.BACKGROUND_WORD)
	else:
		background = Global.to_texture(Element.BACKGROUND_BALL)
		
	region_rect.position = background * Global.TILE_SIZE
	region_rect.size = Vector2(Global.TILE_SIZE, Global.TILE_SIZE)

func _on_target_select(pos: Vector2i, _path: PackedVector2Array) -> void:
	position = pos * Global.TILE_SIZE
	visible = true

func _on_path_follow_finished() -> void:
	visible = false
