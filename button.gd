extends Button

@export_enum("flipper_left", "flipper_right") var action: String
@export var flipper: Flipper

func _ready():
	match OS.get_name():
		"iOS":
			text = ""
		"Android":
			text = ""

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			button_pressed = false

func _physics_process(delta):
	if(Input.is_action_pressed(action)):
		button_pressed = true
	if(Input.is_action_just_released(action)):
		button_pressed = false
	flipper.toggled = button_pressed
