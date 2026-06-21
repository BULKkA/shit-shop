extends Node

var characterStoryList: Array 	= []
var itemsStoryList: Array 		= []

func _ready() -> void:
	var charactersData = GlobalVar.CharactersData
	var itemsData      = GlobalVar.ItemsData
	
	while characterStoryList.size() != 4:
		var random_character = charactersData[randi_range(0, GlobalVar.CharactersData.size() - 1)]
		characterStoryList.append(random_character.id)
		charactersData.erase(random_character)
	while itemsStoryList.size() != 4:
		var random_item = itemsData[randi_range(0, GlobalVar.ItemsData.size() - 1)]
		itemsStoryList.append(random_item.id)
		itemsData.erase(random_item)
	
	Signals.LoadItemField.emit(itemsStoryList)
	Signals.LoadCharacters.emit(characterStoryList)
