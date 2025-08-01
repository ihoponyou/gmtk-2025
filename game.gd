class_name Game
extends Node2D

static var us: Fort
static var them: Fort

const MainMenu := preload("res://ui/MainMenu.tscn")

@export var foreground: TileMapLayer

func _ready() -> void:
	us = $US
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

const TILE_SET_SOURCE_ID := 1
const BACKGROUND_TILE_POS := Vector2i(1, 1)
const COOL_TILE_POS := Vector2i(12, 8)

var last_tile_atlas_coords: Vector2i = Vector2i(-1, -1)
var last_tile_map_pos: Vector2i = Vector2i.ZERO
var should_replace := false

#func _process(delta: float) -> void:
	#var mouse_pos := get_local_mouse_position()
	#var tile_pos := foreground.local_to_map(mouse_pos)
	#
	#if tile_pos == last_tile_map_pos:
		#return
	#
	#should_replace = not Input.is_action_pressed("primary")
	#if should_replace:
		#foreground.set_cell(last_tile_map_pos, TILE_SET_SOURCE_ID, last_tile_atlas_coords)
		#last_tile_atlas_coords = foreground.get_cell_atlas_coords(tile_pos)
	#
	#last_tile_map_pos = tile_pos
	#foreground.set_cell(tile_pos, TILE_SET_SOURCE_ID, COOL_TILE_POS)
