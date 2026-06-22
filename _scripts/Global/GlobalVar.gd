extends Node

var LevelScene 		= load("res://_scenes/Level.tscn")
var SettingScene 	= load("res://_scenes/Settings.tscn")
var PauseScene 		= load("res://_scenes/Pause.tscn")
var MainMenuScene 	= load("res://_scenes/MainMenu.tscn")

var ItemScene 		= load("res://_scenes/item.tscn")

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
