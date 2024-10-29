extends Button

func _ready():
	visible = false
	pressed.connect(func():
		get_tree().reload_current_scene()
	)

func aparecer():
	visible = true
	create_tween().tween_property(self, "scale:y", 1.0, 0.6).from(1.2).set_trans(Tween.TRANS_ELASTIC)
	create_tween().tween_property(self, "scale:x", 1.0, 0.6).from(0.0).set_trans(Tween.TRANS_ELASTIC)
