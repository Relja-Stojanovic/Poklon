extends Control

signal selected_element(data: GameData, pos: Vector2i)
signal selected_target(data: GameData, pos: Vector2i)
signal selection_canceled(data: GameData)

var astar: AStarGrid2D = AStarGrid2D.new()
var data: GameData
var has_selected: bool = false
var selected_pos: Vector2i = Vector2i.MIN

func _ready() -> void:
	data = Global.data
	data.element_added.connect(_on_element_added)
	data.element_removed.connect(_on_element_removed)
	data.element_moved.connect(_on_element_moved)
	
	astar.region = Rect2i(0, 0, data.size, data.size)
	astar.cell_shape = AStarGrid2D.CELL_SHAPE_SQUARE
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.cell_size = Vector2i(Global.TILE_SIZE, Global.TILE_SIZE)
	astar.update()
	
	sync_pathfinding()
	
	if data.word_mode:
		GameService.game_strategy = WordGameStrategy.new()
	else:
		GameService.game_strategy = BallGameStrategy.new()
	
	if data.elements.is_empty():
		GameService.create_preview(data)
		GameService.spawn_elements(data)

func sync_pathfinding() -> void:
	# Check if there are more empty or ocupied slots
	if data.elements.size() > data.size*data.size/2:
		astar.fill_solid_region(astar.region, true)
		for cell in GameService.get_empty_cells(data):
			astar.set_point_solid(cell, false)
	else:
		astar.fill_solid_region(astar.region, false)
		for element in data.elements:
			astar.set_point_solid(element, true)
	
func _on_element_moved(_data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	astar.set_point_solid(old_pos, false)
	astar.set_point_solid(new_pos, true)
	
func _on_element_added(_data: GameData, pos: Vector2i) -> void:
	astar.set_point_solid(pos, true)
	
func _on_element_removed(_data: GameData, pos: Vector2i) -> void:
	astar.set_point_solid(pos, false)

func _on_board_clicked(pos: Vector2i) -> void:
	if has_selected:
		if pos == selected_pos:
			selected_pos = Vector2i.MIN
			has_selected = false
			selection_canceled.emit(data)
		elif data.is_empty(pos):
			var path: PackedVector2Array = astar.get_id_path(selected_pos, pos, false)
			if not path.is_empty():
				data.move_element(selected_pos, pos)
				selected_target.emit(data, selected_pos)
				selected_pos = Vector2i.MIN
				has_selected = false
				#TODO: Fix this shit
				$Board/SelectedElementBackground.visible = false
				$Board/SelectedTargetBackground.visible = false
				$Board/SelectedElement.visible = false
		else:
			selected_pos = pos
			selected_element.emit(data, selected_pos)
	else:
		if not data.is_empty(pos):
			selected_pos = pos
			has_selected = true
			selected_element.emit(data, selected_pos)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.quit()
