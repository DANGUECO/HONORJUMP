extends Control

func _input(event):
	#Ui_cancel = escape.
	if Input.is_action_just_pressed("ui_cancel"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
