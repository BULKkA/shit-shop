extends Control

@onready var volume_slider: HSlider = %VolumeSlider
@onready var volume_value: Label = %VolumeValue
@onready var fullscreen_button: CheckButton = %Fullscreen
@onready var vsync_button: CheckButton = %VSync


func _ready() -> void:
	volume_slider.value = Settings.master_volume * 100.0
	fullscreen_button.button_pressed = Settings.fullscreen
	vsync_button.button_pressed = Settings.vsync_enabled
	_update_volume_label(volume_slider.value)
	%Back.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_close()


func _on_volume_value_changed(value: float) -> void:
	Settings.set_master_volume(value / 100.0, false)
	_update_volume_label(value)


func _on_volume_drag_ended(_value_changed: bool) -> void:
	Settings.save_settings()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	Settings.set_fullscreen(toggled_on)


func _on_v_sync_toggled(toggled_on: bool) -> void:
	Settings.set_vsync(toggled_on)


func _on_back_pressed() -> void:
	_close()


func _update_volume_label(value: float) -> void:
	volume_value.text = "%d%%" % roundi(value)


func _close() -> void:
	Settings.save_settings()
	if get_tree().current_scene == self:
		get_tree().change_scene_to_packed(GlobalVar.MainMenuScene)
	else:
		queue_free()
