extends Node

const TILE_SIZE: int = 16

var data: GameData = null
var settings: Settings = null

func _init() -> void:
	data = DataHandler.load_file(Path.DATA_PATH, GameData)
	settings = DataHandler.load_file(Path.SETTINGS_PATH, Settings)
	
func game_over() -> void:
	data = GameData.new()
	get_tree().reload_current_scene()

func quit() -> void:
	DataHandler.save_file(data, Path.DATA_PATH)
	DataHandler.save_file(settings, Path.SETTINGS_PATH)
	get_tree().quit()

func to_texture(element: int) -> Vector2i:
	var x: int = element % 5
	var y: int = element / 5
	return Vector2i(x, y)
