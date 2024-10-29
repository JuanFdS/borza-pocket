@tool
extends Node2D

var cantidad: int = 0

@export_tool_button("agregar")
var _agregar = agregar
func agregar():
	cantidad += 1
	if get_children().size() == 1 and not get_child(0).visible:
		get_child(0).visible = true
	if get_children().size() < cantidad:
		var new_one = get_children().back().duplicate()
		add_child(new_one)
		new_one.position.x = 30 * (get_child_count() - 1)
