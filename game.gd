class_name Game
extends Node2D

static var us: Fort
static var them: Fort

const TEXTURE_SIZE_PX := 8
const DISPLAY_SCALE := 4
const CELL_SIZE_PX := TEXTURE_SIZE_PX * DISPLAY_SCALE

const MainMenu := preload("res://ui/MainMenu.tscn")

@export var foreground: TileMapLayer

func _ready() -> void:
	us = $Player/US
	them = $THEM
	us.health.amount_changed.connect(_on_our_health_changed)
	
	# FIXME: also chopped
	TurnManager.current_team = Unit.Team.PLAYER
	TurnManager.current_turn = 0
	for unit in UnitManager.all_units:
		unit.queue_free()
	UnitManager.all_units.clear()

func _on_our_health_changed(amount: int):
	if amount > 0:
		return
	get_tree().change_scene_to_packed(MainMenu)
