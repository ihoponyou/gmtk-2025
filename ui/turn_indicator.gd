extends Node

@export var team_label: Label
@export var arrow: AnimatedSprite2D
@export var turn_label: Label

const TEAM_TO_POS: Dictionary[Unit.Team, Vector2] = {
	Unit.Team.PLAYER: Vector2(Game.CELL_SIZE_PX * 13.5, Game.CELL_SIZE_PX * 32.5),
	Unit.Team.ENEMY: Vector2(Game.CELL_SIZE_PX * 13.5, Game.CELL_SIZE_PX * 3.5),
}

const TEAM_TO_TEXT: Dictionary[Unit.Team, String] = {
	Unit.Team.PLAYER: "US",
	Unit.Team.ENEMY: "THEM",
}

const TEAM_TO_ARROW_ROTATION: Dictionary[Unit.Team, float] = {
	Unit.Team.PLAYER: deg_to_rad(-90.0),
	Unit.Team.ENEMY: deg_to_rad(90.0),
}

func _ready() -> void:
	_on_team_changed(TurnManager.current_team)
	TurnManager.team_changed.connect(_on_team_changed)
	_on_turn_changed(0)
	TurnManager.turn_changed.connect(_on_turn_changed)
	arrow.play()

func _on_team_changed(team: Unit.Team):
	team_label.text = TEAM_TO_TEXT[team]
	arrow.position = TEAM_TO_POS[team]
	arrow.rotation = TEAM_TO_ARROW_ROTATION[team]
	
func _on_turn_changed(turn: int):
	#turn_label.text = "%s %d" % ["DAY" if turn % 2 == 0 else "NIGHT", turn / 2]
	turn_label.text = "HOUR %d" % (turn / 2)
