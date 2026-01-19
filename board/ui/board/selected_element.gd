extends Sprite2D

func _on_root_selected_element(data: GameData, pos: Vector2i) -> void:
	var element: int = data.elements[pos]
	var element_texture: Vector2 = Global.to_texture(element)
	
	region_rect.position = element_texture * Global.TILE_SIZE
	position = (Vector2(pos) + Vector2(0.5, 0.5)) * Global.TILE_SIZE
	visible = true
	
