extends Node


func goto_scene(scene: PackedScene):
	_deferred_goto_scene.call_deferred(scene)

func _deferred_goto_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
	
