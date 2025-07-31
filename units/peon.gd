extends Unit
class_name Peon

func take_turn():
	var direction := Vector2i(0, 1 if Unit.Team.ENEMY else -1)
	cell += direction
