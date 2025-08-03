extends TileMapLayer

const UNIT := preload("res://units/Unit.tscn")
const TILE_SET_SOURCE_ID := 1
const BACKGROUND_TILE_POS := Vector2i(1, 1)
const COOL_TILE_POS := Vector2i(12, 8)
const GRID_SIZE := Vector2i(5, 5)

var last_tile_atlas_coords: Vector2i = -Vector2i.ONE
var last_tile_map_pos: Vector2i = Vector2i.ZERO
var should_replace := false

@export var _unit_selector: UnitSelector
@export var _preview: Sprite2D

func _ready() -> void:
	_on_selected_unit_type_changed(_unit_selector.selected_type)
	_unit_selector.selected_type_changed.connect(_on_selected_unit_type_changed)

func _process(delta: float) -> void:
	if not TurnManager.is_player_turn():
		_preview.visible = false
		return
	
	var mouse_pos := get_local_mouse_position()
	var tile_pos := local_to_map(mouse_pos)
	
	if not _is_in_bounds(tile_pos):
		_preview.visible = false
		return
	_preview.visible = true
	var pos_offset := tile_pos as Vector2 + Vector2(0.5, 0.5)
	_preview.position = position + pos_offset * Game.CELL_SIZE_PX
	
	if Input.is_action_pressed("primary"):
		var global_cell_pos := tile_pos + Vector2i(11,25)
		for unit in get_tree().get_nodes_in_group("unit"):
			if unit.cell == global_cell_pos:
				return
		var unit := UNIT.instantiate()
		unit.type = _unit_selector.selected_type
		unit.load_type()
		unit.cell = global_cell_pos
		get_tree().current_scene.add_child(unit)

func _on_selected_unit_type_changed(unit_type: Unit.UnitType):
	_preview.texture = Unit.UNIT_TYPE_TO_TEXTURE[unit_type]

func _is_in_bounds(pos: Vector2) -> bool:
	return pos.x >= 0 and \
		pos.x < GRID_SIZE.x and \
		pos.y >= 0 and \
		pos.y < GRID_SIZE.y
