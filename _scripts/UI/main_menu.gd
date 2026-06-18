extends Control

func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(GlobalVar.LevelScene)

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(GlobalVar.SettingScene)

func _on_exit_pressed() -> void:
	get_tree().quit()
