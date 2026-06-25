extends Node

signal language_changed(language)

const SETTINGS_PATH := "user://settings.cfg"
const AUDIO_SECTION := "audio"
const VIDEO_SECTION := "video"
const GAMEPLAY_SECTION := "gameplay"

const LANGUAGE_OPTIONS := [
	{"id": "ru", "label": "Русский"},
	{"id": "en", "label": "English"}
]

const UI_TEXT := {
	"ru": {
		"main_start": "Начать игру",
		"main_settings": "Настройки",
		"main_exit": "Выход",
		"pause_resume": "Продолжить",
		"pause_exit": "Выйти",
		"settings_title": "Настройки",
		"settings_volume": "Громкость",
		"settings_fullscreen": "Полноэкранный режим",
		"settings_vsync": "Вертикальная синхронизация (VSync)",
		"settings_language": "Язык",
		"settings_back": "Назад",
		"dialog_next": "Далее"
	},
	"en": {
		"main_start": "Start Game",
		"main_settings": "Settings",
		"main_exit": "Exit",
		"pause_resume": "Resume",
		"pause_exit": "Exit",
		"settings_title": "Settings",
		"settings_volume": "Volume",
		"settings_fullscreen": "Fullscreen",
		"settings_vsync": "Vertical Sync (VSync)",
		"settings_language": "Language",
		"settings_back": "Back",
		"dialog_next": "Next"
	}
}

var TextSpeed := 0.03 # секунд на символ
var language := "en"
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
	language = _normalize_language(str(config.get_value(GAMEPLAY_SECTION, "language", language)))


func save_settings() -> void:
	var config := ConfigFile.new()
	config.set_value(AUDIO_SECTION, "master_volume", master_volume)
	config.set_value(VIDEO_SECTION, "fullscreen", fullscreen)
	config.set_value(VIDEO_SECTION, "vsync", vsync_enabled)
	config.set_value(GAMEPLAY_SECTION, "language", language)
	config.save(SETTINGS_PATH)


func apply_settings() -> void:
	set_master_volume(master_volume, false)
	set_fullscreen(fullscreen, false)
	set_vsync(vsync_enabled, false)
	set_language(language, false)


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


func set_language(value: String, save := true) -> void:
	var normalized := _normalize_language(value)
	var changed := language != normalized

	language = normalized
	TranslationServer.set_locale(language)
	var global_var = get_node_or_null("/root/GlobalVar")
	if global_var:
		global_var.load_language_data(language)
	if changed:
		language_changed.emit(language)
	if save:
		save_settings()


func get_language_index() -> int:
	for index in range(LANGUAGE_OPTIONS.size()):
		if LANGUAGE_OPTIONS[index]["id"] == language:
			return index
	return 0


func localize(key: String) -> String:
	var texts = UI_TEXT.get(language, UI_TEXT["ru"])
	return texts.get(key, UI_TEXT["ru"].get(key, key))


func _normalize_language(value: String) -> String:
	for option in LANGUAGE_OPTIONS:
		if option["id"] == value:
			return value
	return "en"
