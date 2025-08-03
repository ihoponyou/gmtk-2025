extends Node

signal team_changed(team: Unit.Team)
signal turn_changed(turn: int)

const UNIT := preload("res://units/Unit.tscn")

var current_team := Unit.Team.PLAYER :
	set(value):
		current_team = value
		team_changed.emit(value)

var current_turn := 0 :
	set(value):
		current_turn = value
		turn_changed.emit(current_turn)


func is_player_turn() -> bool:
	return current_team == Unit.Team.PLAYER

func process_turn():
	for unit: Unit in get_tree().get_nodes_in_group("unit"):
		if unit.type == Unit.UnitType.FORT:
			continue
		if unit.team != current_team:
			continue
		if unit.health.get_amount() <= 0:
			unit.queue_free()
			continue
		unit.take_turn()

	if current_team == Unit.Team.ENEMY:
		if current_turn % 3 == 0:
			for unit in [Unit.UnitType.WIZ]:
				var u := UNIT.instantiate()
				u.load_type()
				u.team = Unit.Team.ENEMY
				u.cell = Vector2i(13, 6)
				get_tree().current_scene.add_child(u)
	
	# get player to place units/buildings
	
	current_team = (current_team + 1) % Unit.Team.size()
	current_turn += 1
