extends Node2D
class_name Unit

const DISPLAY_SCALE := 4
const TEXTURE_SIZE := 8

enum Team {
	PLAYER,
	ENEMY
}

var team := Team.PLAYER
var cell := Vector2i.ZERO :
	get: return cell
	set(value):
		cell = value
		position = cell * DISPLAY_SCALE * TEXTURE_SIZE

func take_turn():
	print("i took my turn")
