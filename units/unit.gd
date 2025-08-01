extends Node2D
class_name Unit

enum Team {
	PLAYER,
	ENEMY
}

const DISPLAY_SCALE := 4
const TEXTURE_SIZE := 8

@export var health: Health
# FIXME: cell value is not initialized properly for scene-instantiated units
@export var cell := Vector2i.ZERO:
	get: return cell
	set(value):
		cell = value
		position = cell * DISPLAY_SCALE * TEXTURE_SIZE
@export var attack_range := 0
var team := Team.PLAYER

# this is also chopped idk what i was doing
func get_enemy_fort_from_team(friendly_team: Unit.Team) -> Fort:
	if friendly_team == Unit.Team.PLAYER:
		return Game.them
	return Game.us

func take_turn():
	print("i took my turn")

func is_in_range(unit: Unit) -> bool:
	var distance = (unit.cell - cell).length()
	return distance <= attack_range
	
