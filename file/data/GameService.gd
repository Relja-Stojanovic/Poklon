class_name GameService extends RefCounted

static var game_strategy: GameStrategy

static func is_game_over(data: GameData) -> bool:
	return data.size*data.size - data.elements.size() <= data.spawn_amount

static func get_empty_cells(data: GameData) -> Array[Vector2i]:
	var empty_cells: Array[Vector2i] = []
	empty_cells.resize(data.size * data.size)
	var count = 0
	for x in range(data.size):
		for y in range(data.size):
			var pos = Vector2i(x, y)
			if not data.elements.has(pos):
				empty_cells[count] = pos
				count += 1
	empty_cells.resize(count)
	empty_cells.shuffle()
	return empty_cells

static func create_preview(data: GameData) -> void:
	var new_preview: Array[int] = []
	new_preview.resize(data.spawn_amount)
	for i in range(data.spawn_amount):
		new_preview.set(i, game_strategy.gen_preview_element())
	data.set_preview(new_preview)
	
static func spawn_elements(data: GameData) -> void:
	if GameService.is_game_over(data):
		Global.game_over()
		return
	
	var empty_cells: Array[Vector2i] = GameService.get_empty_cells(data)
	for i in data.spawn_amount:
		var pos: Vector2i = empty_cells.pop_back()
		var element: int = data.preview.pop_back()
		data.add_element(pos, element)
		game_strategy.execute_match(data, pos)
	create_preview(data)

static func valid_pos(data: GameData, pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x < data.size and pos.y < data.size
