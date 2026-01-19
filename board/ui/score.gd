extends Label

const DISPLAY_COUNT: int = 7
const LIMIT = pow(10, DISPLAY_COUNT) - 1

func _ready() -> void:
	update(Global.data)
	Global.data.score_changed.connect(_on_score_changed)

func _on_score_changed(data: GameData) -> void:
	update(data)

func update(data: GameData) -> void:
	var score: int = clamp(data.score, 0, LIMIT)
	text = str(score).pad_zeros(DISPLAY_COUNT)
