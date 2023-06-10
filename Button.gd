extends Button

var lineScene = preload("res://DragLine.tscn")

func _on_Button_pressed():
	var line = lineScene.instance()
	get_node("/root/TestScene/").add_child(line)
	line.global_position = rect_position
