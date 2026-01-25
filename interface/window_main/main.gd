extends Control

func _ready() -> void:
	data = Global.data
	pathfind = Pathfind.new(data)
	
	if data.word_mode:
		GameService.game_strategy = WordGameStrategy.new()
	else:
		GameService.game_strategy = BallGameStrategy.new()
		
	if data.elements.is_empty():
		GameService.create_preview(data)
		GameService.spawn_elements(data)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.quit()

#TODO: Code Smell
#region Selecting and Moving

@export var board_display: BoardDisplay
var data: GameData
var selected_pos: Vector2i = Vector2i.MIN
var pathfind: Pathfind
var input_active: bool = true


func reset_selection() -> void:
	selected_pos = Vector2i.MIN
	
func has_selected() -> bool:
	return not selected_pos == Vector2i.MIN

func has_path(path: PackedVector2Array) -> bool:
	return not path.is_empty()

func _on_board_clicked(pos: Vector2i) -> void:
	if not input_active:
		return
		
	if has_selected():
		if pos == selected_pos:
			reset_selection()
			board_display.display_element_cancel()
		elif data.is_empty(pos):
			var path: PackedVector2Array = pathfind.find_path(selected_pos, pos)
			if has_path(path):
				input_active = false
				data.move_element(selected_pos, pos)
				await board_display.display_target_select(pos, path)
				input_active = true
				reset_selection()
				
				var connected: bool = GameService.game_strategy.execute_match(data, pos)
				if not connected or data.elements.is_empty():
					GameService.spawn_elements(data)
			else:
				board_display.display_target_unreachable()
		else:
			selected_pos = pos
			board_display.display_element_select(selected_pos)
	else:
		if not data.is_empty(pos):
			selected_pos = pos
			board_display.display_element_select(selected_pos)
#endregion
