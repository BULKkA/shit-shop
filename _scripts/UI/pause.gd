extends Control


func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_settings_pressed() -> void:
	get_tree().root.add_child(GlobalVar.SettingScene)

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_packed(GlobalVar.MainMenuScene)
