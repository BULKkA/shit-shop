extends Panel

@onready var textLabel : Label = $Label 
@onready var NextButton : Button = $Next
var character_id
var problem_id
var item_id

func _ready() -> void:
	Signals.Start_Dialog.connect(Start_Dialog) 

func set_text(text):
	textLabel.text = text

func Start_Dialog(Character_id, Problem_id):
	problem_id = Problem_id
	item_id = null
	character_id = Character_id
	var text_array = GlobalVar.HelloDialogData[character_id]
	var text = text_array[randi_range(0, text_array.size() - 1)]
	await set_text(text)
	NextButton.visible = true
	
func Next_Dialog(character_id, problem_id = null, item_id = null):
	if item_id == null:
		var text_array = GlobalVar.ProblemsData[character_id][problem_id]
		var text = text_array[randi_range(0, text_array.size() - 1)]
		set_text(text)
	else:
		var text_array = GlobalVar.ReactionDialogeData[character_id][item_id]
		var text = text_array[randi_range(0, text_array.size() - 1)]
		set_text(text)

func _on_next_pressed() -> void:
	NextButton.visible = false
	Next_Dialog(character_id, problem_id)
