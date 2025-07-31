extends Node

signal team_changed(team: Unit.Team)

var current_team := Unit.Team.PLAYER

func process_turn():
	for unit in UnitManager.units:
		if unit.team != current_team:
			continue
		unit.take_turn()
	current_team = (current_team + 1) % Unit.Team.size()
	team_changed.emit(current_team)
