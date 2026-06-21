extends Node

signal Play_Sound(Type, Name)

signal Start_Level(LevelData)

signal LoadItemField(item_list)
signal LoadCharacters(character_list)

signal Start_Dialog(character_id)

signal Give_Item(item_id)

signal NextDialog(character_id, problem_id, item_id)
signal NextCharacter()
signal ResultDialog(character_id, problem_id, item_id)

signal End_Day()
