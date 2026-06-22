extends Node

enum Type{
	Music,
	SFX
}

@onready var Theme_main 			= load("res://_song/Theme_main.mp3")
@onready var Theme_roge 			= load("res://_song/Theme_roge.mp3")
@onready var Theme_elf 				= load("res://_song/Theme_elf.mp3")
@onready var Theme_guard 			= load("res://_song/Theme_guard.mp3")
@onready var Theme_wizard 			= load("res://_song/Theme_wizard.mp3")
@onready var Theme_elephant_paladin = load("res://_song/Theme_elephant_paladin.mp3")

var themes = {
	"Theme_main": Theme_main,
	"Theme_roge": Theme_roge,
	"Theme_elf": Theme_elf,
	"Theme_guard": Theme_guard,
	"Theme_wizard": Theme_wizard,
	"Theme_elephant_paladin": Theme_elephant_paladin
}

func soundByName(Name):
	return themes.get(name)

func _ready() -> void:
	Signals.Play_Sound.emit(Type.Music, "main")
