extends Control

func _ready() -> void:
	Settings.language_changed.connect(_on_language_changed)
	_apply_localization()


func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_settings_pressed() -> void:
	var settings_menu = GlobalVar.SettingScene.instantiate()
	add_child(settings_menu)

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(GlobalVar.MainMenuScene)


func _on_language_changed(_language: String) -> void:
	_apply_localization()


func _apply_localization() -> void:
	$Panel/CenterContainer/VBoxContainer/Resume.text = Settings.localize("pause_resume")
	$Panel/CenterContainer/VBoxContainer/Settings.text = Settings.localize("main_settings")
	$Panel/CenterContainer/VBoxContainer/Exit.text = Settings.localize("pause_exit")
