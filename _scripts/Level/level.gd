extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().current_scene.add_child(GlobalVar.PauseScene)
		get_tree().paused = true
