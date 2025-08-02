extends Button

@export var timer: Timer
@export var fast_toggle: CheckButton

var _fast_mode := false

func _ready() -> void:
	fast_toggle.toggled.connect(func (on: bool): _fast_mode = on)

func _pressed() -> void:
	TurnManager.process_turn()
	
	if TurnManager.current_team != Unit.Team.PLAYER:
		disabled = true
		
		if not _fast_mode:
			timer.start()
			await timer.timeout
		TurnManager.process_turn()
		
		disabled = false
