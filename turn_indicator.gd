extends Node

@onready var label := $TeamLabel
@onready var arrow := $ArrowIndicator

const TEAM_TO_POS: Dictionary[Unit.Team, Vector2] = {
	Unit.Team.PLAYER: Vector2i(400, 976),
	Unit.Team.ENEMY: Vector2i(400, 176),
}

const TEAM_TO_TEXT: Dictionary[Unit.Team, String] = {
	Unit.Team.PLAYER: "YOUR TURN",
	Unit.Team.ENEMY: "THEIR TURN",
}

func _ready() -> void:
	TurnManager.team_changed.connect(_on_team_changed)
	
func _on_team_changed(team: Unit.Team):
	label.text = TEAM_TO_TEXT[team]
	arrow.position = TEAM_TO_POS[team]
