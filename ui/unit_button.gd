class_name UnitButton
extends Control

const UNIT_LABEL_FORMAT := "[color={color}][[/color]{first_char}[color={color}]][/color]{remaining_chars}"

@export var outline: Panel
@export var unit_name_label: RichTextLabel
@export var unit_name: String
@export var button: Button
@export var is_selected := false :
	set(value):
		is_selected = value
		_toggle_selected(value)

@export var _texture_rect: TextureRect

func set_texture(tex: Texture):
	_texture_rect.texture = tex

func set_shortcut_key(keycode: Key):
	var ie_key := InputEventKey.new()
	ie_key.physical_keycode = keycode
	var shortcut := Shortcut.new()
	shortcut.events = [ie_key]
	button.shortcut = shortcut

func _ready() -> void:
	_toggle_selected(is_selected)

func _toggle_selected(selected: bool):
	#outline.visible = selected
	var stylebox := outline.get_theme_stylebox("panel").duplicate()
	stylebox.set("border_color", Color.ORANGE if selected else Color.WHITE)
	outline.add_theme_stylebox_override("panel", stylebox)
	
	var color := "orange" if selected else "white"
	unit_name_label.text = UNIT_LABEL_FORMAT.format({
		"color": color,
		"first_char": unit_name[0],
		"remaining_chars": unit_name.substr(1),
	})
