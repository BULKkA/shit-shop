extends Control

func _ready() -> void:
	Settings.language_changed.connect(_on_language_changed)
	_apply_localization()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(GlobalVar.LevelScene)

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(GlobalVar.SettingScene)

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_language_changed(_language: String) -> void:
	_apply_localization()


func _apply_localization() -> void:
	$CenterContainer/VBoxContainer/Start.text = Settings.localize("main_start")
	$CenterContainer/VBoxContainer/Settings.text = Settings.localize("main_settings")
	$CenterContainer/VBoxContainer/Exit.text = Settings.localize("main_exit")
