class_name Peon
extends Unit



func take_turn():
	var enemy := get_enemy_fort_from_team(team)
	if is_in_range(enemy):
		enemy.health.damage(1)
		return
	
	var direction := Vector2i(0, 1 if Unit.Team.ENEMY else -1)
	cell += direction
	
