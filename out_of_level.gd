extends Area2D

signal ball_out_of_bounds

func _ready():
	body_entered.connect(func(_ball):
		_ball.queue_free()
		await get_tree().create_timer(1.0).timeout
		ball_out_of_bounds.emit()
	)
