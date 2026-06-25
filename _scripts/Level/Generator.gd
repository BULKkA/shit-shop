extends Node

var characterStoryList: Array 	= []
var problemStoryList: Array 	= []
var itemsStoryList: Array 		= []

func _ready() -> void:
	LoadGameData()

func LoadGameData():
	characterStoryList.clear()
	problemStoryList.clear()
	itemsStoryList.clear()
	GlobalVar.CanDropItem = false

	var charactersData = GlobalVar.CharactersData.duplicate(true)
	var problemData    = GlobalVar.ProblemsData.duplicate(true)
	var itemsData      = GlobalVar.ItemsData.duplicate(true)
	
	while characterStoryList.size() != 4:
		var random_character = charactersData[randi_range(0, charactersData.size() - 1)]
		characterStoryList.append(random_character.id)
		charactersData.erase(random_character)
	while problemStoryList.size() != 4:
		var random_problem = problemData[randi_range(0, problemData.size() - 1)]
		problemStoryList.append(random_problem.id)
		problemData.erase(random_problem)
	while itemsStoryList.size() != 4:
		var random_item = itemsData[randi_range(0, itemsData.size() - 1)]
		itemsStoryList.append(random_item.id)
		itemsData.erase(random_item)
	
	Signals.LoadItemField.emit(itemsStoryList)
	Signals.LoadCharacters.emit(characterStoryList, problemStoryList)
