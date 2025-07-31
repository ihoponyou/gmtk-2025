extends Node

signal team_changed(team: Unit.Team)
signal turn_changed(turn: int)

var current_team := Unit.Team.PLAYER :
	set(value):
		current_team = value
		team_changed.emit(value)

var current_turn := 0 :
	set(value):
		current_turn = value
		turn_changed.emit(current_turn)

func process_turn():
	if current_team == Unit.Team.ENEMY:
		var units := UnitManager.choose_units()
		for unit in units:
			UnitManager.spawn_unit(unit)
	# place units/buildings
	
	for unit in UnitManager.all_units:
		if unit.team != current_team:
			continue
		unit.take_turn()
	
	current_team = (current_team + 1) % Unit.Team.size()
	current_turn += 1
	
