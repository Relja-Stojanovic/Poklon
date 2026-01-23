extends MenuButton

enum {
	SFX,
	MUSIC,
	STYLE
}

func _ready() -> void:
	get_popup().index_pressed.connect(_on_index_pressed)
	var settings: Settings = Global.settings
	settings.sfx_changed.connect(_on_sfx_changed)
	settings.music_changed.connect(_on_music_changed)
	_on_sfx_changed(settings)
	_on_music_changed(settings)

func _on_index_pressed(index: int) -> void:
	match index:
		SFX:
			Global.settings.toggle_sfx()
		MUSIC:
			Global.settings.toggle_music()
		STYLE:
			Global.settings.next_style()

func _on_file_menu_button_pressed() -> void:
	hide()

func _on_sfx_changed(settings: Settings) -> void:
	get_popup().set_item_checked(SFX, settings.sfx)
	
func _on_music_changed(settings: Settings) -> void:
	get_popup().set_item_checked(MUSIC, settings.music)
