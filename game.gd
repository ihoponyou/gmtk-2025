class_name Game
extends Node2D

const TEXTURE_SIZE_PX := 8
const DISPLAY_SCALE := 4
const CELL_SIZE_PX := TEXTURE_SIZE_PX * DISPLAY_SCALE


func _ready() -> void:
	%US.health.amount_changed.connect(_on_our_health_changed)
	
	# FIXME: also chopped
	TurnManager.current_team = Unit.Team.PLAYER
	TurnManager.current_turn = 0

func _on_our_health_changed(amount: int):
	if amount > 0:
		return
	get_tree().call_deferred("reload_current_scene")
