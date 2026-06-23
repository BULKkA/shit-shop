extends Node

const SETTINGS_PATH := "user://settings.cfg"
const AUDIO_SECTION := "audio"
const VIDEO_SECTION := "video"

var TextSpeed := 0.03 # секунд на символ
var master_volume := 1.0
var fullscreen := false
var vsync_enabled := true


func _ready() -> void:
	load_settings()
	apply_settings()


func load_settings() -> void:
	var config := ConfigFile.new()
	if config.load(SETTINGS_PATH) != OK:
		return

	master_volume = clampf(
		float(config.get_value(AUDIO_SECTION, "master_volume", master_volume)),
		0.0,
		1.0
	)
	fullscreen = bool(config.get_value(VIDEO_SECTION, "fullscreen", fullscreen))
	vsync_enabled = bool(config.get_value(VIDEO_SECTION, "vsync", vsync_enabled))


func save_settings() -> void:
	var config := ConfigFile.new()
	config.set_value(AUDIO_SECTION, "master_volume", master_volume)
	config.set_value(VIDEO_SECTION, "fullscreen", fullscreen)
	config.set_value(VIDEO_SECTION, "vsync", vsync_enabled)
	config.save(SETTINGS_PATH)


func apply_settings() -> void:
	set_master_volume(master_volume, false)
	set_fullscreen(fullscreen, false)
	set_vsync(vsync_enabled, false)


func set_master_volume(value: float, save := true) -> void:
	master_volume = clampf(value, 0.0, 1.0)
	var master_bus := AudioServer.get_bus_index("Master")
	if master_bus >= 0:
		AudioServer.set_bus_mute(master_bus, master_volume <= 0.001)
		AudioServer.set_bus_volume_db(master_bus, linear_to_db(maxf(master_volume, 0.001)))
	if save:
		save_settings()


func set_fullscreen(enabled: bool, save := true) -> void:
	fullscreen = enabled
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)
	if save:
		save_settings()


func set_vsync(enabled: bool, save := true) -> void:
	vsync_enabled = enabled
	var mode := DisplayServer.VSYNC_ENABLED if vsync_enabled else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(mode)
	if save:
		save_settings()
