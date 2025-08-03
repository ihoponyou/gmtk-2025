class_name Health
extends Node2D

signal amount_changed(amount: int)

@export var _bar_background: ColorRect
@export var _bar_foreground: ColorRect

@export var _max_amount := 10.0
@export var _amount := 10.0 :
	set(value):
		if _amount == value:
			return
		_amount = value
		amount_changed.emit(value)
		_update_bar()


func get_amount() -> int:
	return _amount

func damage(amount: int) -> int:
	_amount -= min(_amount, amount)
	return _amount

func _update_bar():
	var width := _bar_background.size.x * (_amount / _max_amount)
	_bar_foreground.size = Vector2(width, _bar_background.size.y)
