class_name Settings extends Resource

enum Styles {
	NORMAL,
	CLASSIC,
	BOOK,
	MAX
}

signal sfx_changed(settings: Settings)
signal music_changed(settings: Settings)
signal style_changed(settings: Settings)

@export var sfx: bool = true
@export var music: bool = true
@export var style: int = 0

func set_sfx(value: bool) -> void:
	sfx = value
	sfx_changed.emit(self)

func set_music(value: bool) -> void:
	music = value
	music_changed.emit(self)

func set_style(value: int) -> void:
	style = value
	style_changed.emit(self)

func toggle_sfx() -> void:
	set_sfx(not sfx)
	
func toggle_music() -> void:
	set_music(not music)
	
func next_style() -> void:
	var new_style = (style + 1) % Styles.MAX
	set_style(new_style)
