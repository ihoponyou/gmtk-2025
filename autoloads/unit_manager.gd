extends Node

const PEON := preload("res://units/Peon.tscn")

var all_units: Array[Unit] = []

func choose_units() -> Array[Unit]:
	var units: Array[Unit] = []
	for i in 1:
		var peon := PEON.instantiate()
		peon.cell = Vector2i(i, i)
		peon.team = Unit.Team.ENEMY
		units.append(peon)
	return units

func spawn_unit(unit: Unit):
	all_units.append(unit)
	get_tree().root.add_child(unit)
