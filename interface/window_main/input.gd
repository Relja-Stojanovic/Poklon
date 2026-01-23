extends TextureRect

# https://github.com/godotengine/godot/issues/99912
# Just know it gets mouse position and emits singal when board is clicked

signal board_clicked(pos: Vector2i)

func _input(_event: InputEvent) -> void:
	if not Input.is_action_just_pressed("click"):
		return
		
	var mouse_pos: Vector2 = get_local_mouse_position()
	var tile_size: Vector2 = size / Global.data.size
	var clicked_pos: Vector2i = floor(mouse_pos / tile_size)
	if GameService.valid_pos(Global.data, clicked_pos):
		board_clicked.emit(clicked_pos)
