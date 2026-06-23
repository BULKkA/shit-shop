extends Node

enum Type{
	Music,
	SFX
}

var themes = {
	"Theme_main": preload("res://_song/Theme_main.mp3"),
	"Theme_roge": preload("res://_song/Theme_roge.mp3"),
	"Theme_elf": preload("res://_song/Theme_elf.mp3"),
	"Theme_guard": preload("res://_song/Theme_guard.mp3"),
	"Theme_wizard": preload("res://_song/Theme_wizard.mp3"),
	"Theme_elephant_paladin": preload("res://_song/Theme_elephant_paladin.mp3")
}

func soundByName(Name):
	return themes.get(Name)

func _ready() -> void:
	Signals.Play_Sound.emit(Type.Music, "main")
	
