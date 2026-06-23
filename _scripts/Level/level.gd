extends Control


func _ready() -> void:
	Signals.End_Day.connect(_on_end_game)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().get_first_node_in_group("pause_menu"):
			return
		var pause_menu = GlobalVar.PauseScene.instantiate()
		get_tree().current_scene.add_child(pause_menu)
		get_tree().paused = true


func _on_end_game() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(GlobalVar.MainMenuScene)
