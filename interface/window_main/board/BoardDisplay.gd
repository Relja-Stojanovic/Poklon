class_name BoardDisplay extends Node2D

signal element_select(pos: Vector2i)
signal element_cancel()
signal target_select(pos: Vector2i, path: PackedVector2Array)
signal target_unreachable()

func display_element_select(pos: Vector2i) -> void:
	element_select.emit(pos)

func display_element_cancel() -> void:
	element_cancel.emit()

func display_target_select(pos: Vector2i, path: PackedVector2Array) -> void:
	target_select.emit(pos, path)
	await $Path/PathFollow.finished

func display_target_unreachable() -> void:
	target_unreachable.emit()
