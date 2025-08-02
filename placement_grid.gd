extends Control

const SCALE := 32
const GRID_SIZE := Vector2(5, 5)
const GRID_OFFSET := Vector2(0, -(GRID_SIZE.y + 1))

func _draw() -> void:
	draw_rect(Rect2(GRID_OFFSET * SCALE, GRID_SIZE * SCALE), Color.WHITE, false, 1.0)
	for x in GRID_SIZE.x:
		var from := Vector2(x * SCALE, -1 * SCALE)
		var to := Vector2(from.x, )
		draw_line(, )
