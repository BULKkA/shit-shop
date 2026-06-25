extends Node

var LevelScene 		= load("res://_scenes/Level.tscn")
var SettingScene 	= load("res://_scenes/Settings.tscn")
var PauseScene 		= load("res://_scenes/Pause.tscn")
var MainMenuScene 	= load("res://_scenes/MainMenu.tscn")

var ItemScene 		= load("res://_scenes/item.tscn")

const LOCALIZED_DATA_FILES := {
	"ProblemsData": "Problems",
	"ItemsData": "Items",
	"CharactersData": "Characters",
	"HelloDialogData": "Hello_Dialogs",
	"ReactionDialogeData": "Reaction_Dialogs",
	"ProblemDialogsData": "Problem_Dialogs",
	"ResultDialogData": "Results"
}

#data
var DefaultGlobalSettings   = load("res://_data/Default_Global_Settings.tres").data
var ProblemsData            = load("res://_data/Problems.tres").data
var ItemsData               = load("res://_data/Items.tres").data
var CharactersData          = load("res://_data/Characters.tres").data
var HelloDialogData         = load("res://_data/Hello_Dialogs.tres").data
var ReactionDialogeData     = load("res://_data/Reaction_Dialogs.tres").data
var ProblemDialogsData		= load("res://_data/Problem_Dialogs.tres").data
var ResultDialogData		= load("res://_data/Results.tres").data

var CanDropItem: bool = false


func _ready() -> void:
	load_language_data(Settings.language)


func load_language_data(language: String) -> void:
	ProblemsData = _load_localized_data(LOCALIZED_DATA_FILES["ProblemsData"], language)
	ItemsData = _load_localized_data(LOCALIZED_DATA_FILES["ItemsData"], language)
	CharactersData = _load_localized_data(LOCALIZED_DATA_FILES["CharactersData"], language)
	HelloDialogData = _load_localized_data(LOCALIZED_DATA_FILES["HelloDialogData"], language)
	ReactionDialogeData = _load_localized_data(LOCALIZED_DATA_FILES["ReactionDialogeData"], language)
	ProblemDialogsData = _load_localized_data(LOCALIZED_DATA_FILES["ProblemDialogsData"], language)
	ResultDialogData = _load_localized_data(LOCALIZED_DATA_FILES["ResultDialogData"], language)


func _load_localized_data(base_name: String, language: String):
	var suffix := "" if language == "ru" else "_" + language
	var path := "res://_data/%s%s.tres" % [base_name, suffix]
	if not ResourceLoader.exists(path):
		path = "res://_data/%s.tres" % base_name
	return load(path).data
