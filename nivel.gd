extends Node2D

var has_game_finished: bool = false
@onready var ball = %Ball

func _ready():
	%Ball.freeze = true
	%Borza.disabled = true
	%Empezar.pressed.connect(func():
		if not %Ball.freeze:
			return
		$AudioStreamPlayer.play()
		%Timer.start()
		%Borza.disabled = false
		%Ball.freeze = false
		create_tween().tween_property(%Empezar, "scale:x", 0.0, 0.5).set_trans(Tween.TRANS_CUBIC)
	)

	%Timer.timeout.connect(func():
		finish_game()
	)

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		%Empezar.pressed.emit()

func _process(delta):
	%TimerLabel.text = "%01d:%02d" % [%Timer.time_left / 60.0, fmod(%Timer.time_left, 60.0)]

func finish_game():
	if(has_game_finished): return
	
	has_game_finished = true
	$AudioStreamPlayer.stop()
	$Finish.play()
	%Timer.stop()
	[%Flipper, %Flipper2].map(func(flipper): flipper.disable()
	)
	%Borza.disable()
	if(is_instance_valid(ball)):
		await ball.tree_exited
	await get_tree().create_timer(1.0).timeout
	await %MensajeGameOver.aparecer()
	%JugarDeNuevo.aparecer()


func _on_out_of_level_ball_out_of_bounds():
	finish_game()
