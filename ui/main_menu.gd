extends Control

const Game = preload("res://game.tscn")

func _unhandled_input(event: InputEvent) -> void:
	get_tree().change_scene_to_packed(Game)
