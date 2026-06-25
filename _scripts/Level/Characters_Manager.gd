extends Node

var character_list: Array
var problem_list: Array
var charecter_index: int = 0
var max_index: int

func _ready() -> void:
	Signals.LoadCharacters.connect(LoadCharacters)
	Signals.NextCharacter.connect(NextCharacter)

func LoadCharacters(Character_list, Problem_list):
	charecter_index = 0
	character_list 	= Character_list
	problem_list   	= Problem_list
	max_index 		= character_list.size() - 1
	Signals.Start_Dialog.emit(character_list[charecter_index], problem_list[charecter_index])

func NextCharacter():
	charecter_index += 1
	if charecter_index <= max_index:
		Signals.Start_Dialog.emit(character_list[charecter_index], problem_list[charecter_index])
	else:
		Signals.End_Day.emit()
