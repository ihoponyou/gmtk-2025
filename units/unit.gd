extends Node2D
class_name Unit

enum Team {
	PLAYER,
	ENEMY
}

enum UnitType {
	PEON,
	WIZ,
	FORT,
}

const UNIT_TYPE_TO_DISPLAY_NAME: Dictionary[UnitType, String] = {
	UnitType.PEON: "Peon",
	UnitType.WIZ: "Wiz",
	UnitType.FORT: "Fort",
}

const UNIT_TYPE_TO_TEXTURE: Dictionary[UnitType, Texture] = {
	UnitType.PEON: preload("res://assets/tex_peon.tres"),
	UnitType.WIZ: preload("res://assets/tex_wiz.tres"),
	UnitType.FORT: preload("res://assets/tex_fort.tres"),
}

const _ATTACK_RANGES: Dictionary[UnitType, int] = {
	UnitType.PEON: 1,
	UnitType.WIZ: 3,
	UnitType.FORT: 0,
}

const _DAMAGES: Dictionary[UnitType, int] = {
	UnitType.PEON: 1,
	UnitType.WIZ: 2,
	UnitType.FORT: 0,
}

static var our_fort: Unit
static var their_fort: Unit

@export var health: Health
# FIXME: cell value is not initialized properly for editor-instantiated units
@export var cell := Vector2i.ZERO:
	set(value):
		cell = value
		position = cell * Game.CELL_SIZE_PX
@export var type := UnitType.PEON
@export var team := Team.PLAYER

@export var _sprite: Sprite2D
var _damage := 0
var _attack_range := 0


func load_type():
	_damage = _DAMAGES[type]
	_attack_range = _ATTACK_RANGES[type]

func take_turn():
	var enemy := _find_enemy_unit_in_front()
	if enemy != null:
		enemy.health.damage(_damage)
		return
	var direction := Vector2i(0, 1 if team == Unit.Team.ENEMY else -1)
	for unit in get_tree().get_nodes_in_group("unit"):
		if unit.cell == cell + direction:
			return
	cell += direction

func is_in_range(unit: Unit) -> bool:
	var distance = (unit.cell - cell).length()
	return distance <= _attack_range

func is_alive() -> bool:
	return health.get_amount() > 0

func _find_enemy_unit_in_front() -> Unit:
	for unit in get_tree().get_nodes_in_group("unit"):
		if unit.team == team:
			continue
		if is_in_range(unit):
			return unit
	return null

func _ready() -> void:
	if type == UnitType.FORT:
		if team == Unit.Team.PLAYER:
			our_fort = self
		else:
			their_fort = self
		health.position = Vector2(-64, 40 if (team == Team.PLAYER) else -16)
		health.scale.x = 5
	_sprite.texture = UNIT_TYPE_TO_TEXTURE[type]
