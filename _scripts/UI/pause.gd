extends Control


func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_settings_pressed() -> void:
	var settings_menu = GlobalVar.SettingScene.instantiate()
	add_child(settings_menu)

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(GlobalVar.MainMenuScene)
