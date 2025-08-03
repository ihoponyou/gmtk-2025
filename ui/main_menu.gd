class_name MainMenu
extends Control

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_pressed() or not visible:
		return
	visible = false
	$AudioStreamPlayer.play()
