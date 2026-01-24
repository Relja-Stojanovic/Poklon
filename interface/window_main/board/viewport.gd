extends SubViewport

func _ready() -> void:
	size = Vector2i.ONE * (Global.TILE_SIZE * Global.data.size)
