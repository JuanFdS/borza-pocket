class_name Flipper extends StaticBody2D

@export_range(-180, 360, 0.001, "radians_as_degrees")
var rotation_when_toggled: float
var original_rotation = rotation
var rotation_percentage = 0.0

var disabled: bool = false
var toggled: bool = false

func is_toggled():
	return toggled and not disabled

func disable():
	modulate = Color.DARK_GRAY
	disabled = true

func _ready():
	original_rotation = rotation

func _physics_process(delta):
	var target_rotation_percentage = 1.0 if is_toggled() else 0.0
	var previous_rotation_percentage = rotation_percentage
	rotation_percentage = move_toward(
		rotation_percentage,
		target_rotation_percentage,
		delta * 10.0
	)
	var delta_rotation_percentage = rotation_percentage - previous_rotation_percentage
	#if is_toggled() and delta_rotation_percentage > 0.0:
		#constant_linear_velocity = Vector2.ZERO#Vector2.UP * 1000.0
	#else:
		#constant_linear_velocity = Vector2.ZERO
	rotation = lerp_angle(original_rotation, rotation_when_toggled, rotation_percentage)
