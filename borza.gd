extends CharacterBody2D

const SPEED = 200.0
@export var positions: Array[Node2D]
@onready var sprite = %Sprite
var vibration: Vector2
@onready var shaker: Shaker = %Shaker
var target: Node2D
const REMERA_GODOT = preload("res://remera_godot.tscn")

var disabled: bool = false

func disable():
	disabled = true

func _ready():
	set_random_target()

func set_random_target():
	target = positions.pick_random()

func being_hit() -> bool:
	return shaker.is_processing()
	

func _physics_process(delta):
	sprite.position = vibration
	modulate = modulate.lerp(Color.WHITE, 0.1)
	if being_hit() or disabled:
		return
	if(is_instance_valid(target)):
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * SPEED
		move_and_slide()
		if(global_position.distance_to(target.global_position) <= 10.0):
			set_random_target()
	if velocity.x < 0:
		sprite.flip_h = false
	elif velocity.x > 0:
		sprite.flip_h = true


func hit_by_ball(ball):
	if(being_hit()): return
	$Hit.play()
	modulate = Color.BLACK
	shaker.start()
	await get_tree().create_timer(0.05).timeout
	var remera = REMERA_GODOT.instantiate()
	get_parent().add_child(remera)
	remera.conseguida.connect(func():
		$RemeraConseguida.play()
		%RemerasConseguidas.agregar()
	)
	remera.spawn_from(self)
