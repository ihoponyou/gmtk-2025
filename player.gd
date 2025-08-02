class_name Player
extends Node2D

const TILE_SET_SOURCE_ID := 1
const BACKGROUND_TILE_POS := Vector2i(1, 1)
const COOL_TILE_POS := Vector2i(12, 8)
const GRID_SIZE := Vector2i(5, 5)

@export var placement_grid: TileMapLayer

var last_tile_atlas_coords: Vector2i = -Vector2i.ONE
var last_tile_map_pos: Vector2i = Vector2i.ZERO
var should_replace := false

func _process(delta: float) -> void:
	var mouse_pos := placement_grid.get_local_mouse_position()
	var tile_pos := placement_grid.local_to_map(mouse_pos)
	
	if tile_pos == last_tile_map_pos:
		return
	
	should_replace = not Input.is_action_pressed("primary")
	if should_replace:
		placement_grid.set_cell(last_tile_map_pos, TILE_SET_SOURCE_ID, last_tile_atlas_coords)
		last_tile_atlas_coords = placement_grid.get_cell_atlas_coords(tile_pos)
	
	if not _is_in_bounds(tile_pos):
		last_tile_map_pos = -Vector2i.ONE
		return
	
	last_tile_map_pos = tile_pos
	placement_grid.set_cell(tile_pos, TILE_SET_SOURCE_ID, COOL_TILE_POS)

func _is_in_bounds(pos: Vector2) -> bool:
	return pos.x >= 0 and \
		pos.x < GRID_SIZE.x and \
		pos.y >= 0 and \
		pos.y < GRID_SIZE.y
