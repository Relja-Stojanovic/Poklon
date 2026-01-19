extends TileMapLayer

func _ready() -> void:
	Global.data.element_added.connect(_on_element_added)
	Global.data.element_moved.connect(_on_element_moved)
	Global.data.element_removed.connect(_on_element_removed)
	for pos in Global.data.elements:
		_on_element_added(Global.data, pos)

func _on_element_added(data: GameData, pos: Vector2i) -> void:
	var new_element: int = data.elements[pos]
	var texture: Vector2i = Global.to_texture(new_element)
	set_cell(pos, 0, texture)
	
func _on_element_moved(data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	erase_cell(old_pos)
	var element: int = data.elements[new_pos]
	var texture: Vector2i = Global.to_texture(element)
	set_cell(new_pos, 0, texture)
	
func _on_element_removed(_data: GameData, pos: Vector2i) -> void:
	erase_cell(pos)
