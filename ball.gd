extends RigidBody2D

func _ready():
	body_entered.connect(func(body):
		if body.has_method("hit_by_ball"):
			body.hit_by_ball(self)
	)
