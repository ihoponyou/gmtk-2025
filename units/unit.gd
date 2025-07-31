extends Node2D
class_name Unit

enum Team {
	PLAYER,
	ENEMY
}

var team := Team.PLAYER

func take_turn():
	print("i took my turn")
