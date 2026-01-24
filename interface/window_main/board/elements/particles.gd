extends CPUParticles2D

func _ready() -> void:
	var tex: AtlasTexture = texture
	tex.region.size = Vector2i(Global.TILE_SIZE, Global.TILE_SIZE)
