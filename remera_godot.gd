extends CharacterBody2D

const REMERA_CONSEGUIDA_FX = preload("res://remera_conseguida_fx.tscn")

signal conseguida
var was_pushed_this_frame = false

func spawn_from(borza):
	var target_position = borza.global_position + Vector2.RIGHT * 40.0 + Vector2.DOWN * 90.0
	create_tween().tween_property(self, "scale", Vector2.ONE, 0.3).from(Vector2.ZERO).set_trans(Tween.TRANS_QUAD)
	create_tween().tween_property(self, "global_position", target_position, 0.3).from(borza.global_position).set_trans(Tween.TRANS_QUAD)

func hit_by_ball(_ball):
	conseguida.emit()
	stop_colliding.call_deferred()
	create_tween().tween_property(self, "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_QUAD)
	await create_tween().tween_property(self, "rotation", PI * 5.0, 0.3).set_trans(Tween.TRANS_QUAD).finished
	var fx = REMERA_CONSEGUIDA_FX.instantiate()
	get_parent().add_child(fx)
	fx.global_position = global_position
	queue_free()

func _physics_process(delta):
	if(was_pushed_this_frame):
		return
	if $RayCast2D.is_colliding():
		$RayCast2D.get_collider().push_away(delta)
		move_and_collide(Vector2.RIGHT * 200.0 * delta)
	was_pushed_this_frame = false

func push_away(delta):
	was_pushed_this_frame = true
	move_and_collide(Vector2.LEFT * 200.0 * delta)

func stop_colliding():
	collision_layer = 0
	collision_mask = 0
