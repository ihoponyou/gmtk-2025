extends Node

@onready var team_label := $TeamLabel
@onready var arrow := $ArrowIndicator
@onready var turn_label := $TurnLabel

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
	TurnManager.turn_changed.connect(_on_turn_changed)
	arrow.play()

func _on_team_changed(team: Unit.Team):
	team_label.text = TEAM_TO_TEXT[team]
	arrow.position = TEAM_TO_POS[team]
	
func _on_turn_changed(turn: int):
	turn_label.text = "%s %d" % ["DAY" if turn % 2 == 0 else "NIGHT", turn / 2]
