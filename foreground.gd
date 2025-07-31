extends TileMapLayer

const TILE_SET_SOURCE_ID = 1
const BACKGROUND_TILE_POS = Vector2i(1, 1)
const COOL_TILE_POS = Vector2i(12, 8)

var last_tile_atlas_coords: Vector2i = Vector2i(-1, -1)
var last_tile_map_pos: Vector2i = Vector2i.ZERO

func _process(delta: float) -> void:
	var mouse_pos := get_local_mouse_position()
	var tile_pos := local_to_map(mouse_pos)
	if tile_pos == last_tile_map_pos:
		return
	
	set_cell(last_tile_map_pos, TILE_SET_SOURCE_ID, last_tile_atlas_coords)
	last_tile_atlas_coords = get_cell_atlas_coords(tile_pos)
	
	last_tile_map_pos = tile_pos
	set_cell(tile_pos, TILE_SET_SOURCE_ID, COOL_TILE_POS)
	print(tile_pos)
