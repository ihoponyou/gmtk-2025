class_name UnitSelector
extends Control

const UNIT_BUTTON := preload("res://ui/UnitButton.tscn")

signal selected_type_changed(type: Unit.UnitType)

@export var selectable_unit_types: Array[Unit.UnitType]
var selected_type: Unit.UnitType = 0 :
	set(value):
		selected_type = value
		selected_type_changed.emit(value)

@export var _container: Container
var _buttons: Dictionary[Unit.UnitType, UnitButton] = {}

func _ready() -> void:
	for unit_type in selectable_unit_types:
		var unit_button := UNIT_BUTTON.instantiate()
		unit_button.unit_name = Unit.UNIT_TYPE_TO_DISPLAY_NAME[unit_type]
		unit_button.is_selected = unit_type == 0
		unit_button.set_texture(Unit.UNIT_TYPE_TO_TEXTURE[unit_type])
		var shortcut_key := OS.find_keycode_from_string(unit_button.unit_name[0])
		unit_button.set_shortcut_key(shortcut_key)
		unit_button.button.pressed.connect(_on_button_pressed.bind(unit_type))
		
		_buttons[unit_type] = unit_button
		_container.add_child(unit_button)

func _on_button_pressed(unit_type: Unit.UnitType):
	_buttons[selected_type].is_selected = false
	_buttons[unit_type].is_selected = true
	selected_type = unit_type
