extends Panel

@onready var textLabel : Label = $Label 
@onready var NextButton : Button = $Next
var character_id
var problem_id
var item_id
var is_end = false
var next_character = false

func _ready() -> void:
	Signals.Start_Dialog.connect(Start_Dialog) 
	Signals.Give_Item.connect(Give_Item)
	Signals.set_next_button_status.connect(set_next_button_status)
	Settings.language_changed.connect(_on_language_changed)
	_apply_localization()

var _typing_id := 0

func set_text(text: String):
	_typing_id += 1
	var current_id = _typing_id
	textLabel.text = ""
	for char in text:
		if current_id != _typing_id:
			return
		textLabel.text += char
		await get_tree().create_timer(Settings.TextSpeed).timeout
	Signals.text_finished.emit()

func Start_Dialog(Character_id, Problem_id):
	problem_id = Problem_id
	item_id = null
	character_id = Character_id
	var text_array = GlobalVar.HelloDialogData[character_id]
	var text = text_array[randi_range(0, text_array.size() - 1)]
	set_text(text.text)
	await Signals.text_finished
	Signals.set_next_button_status.emit(true)

func Next_Dialog(Character_id, Problem_id = null, Item_id = null):
	if Item_id == null:
		var text_array = GlobalVar.ProblemDialogsData[Character_id][Problem_id]
		var text = text_array[randi_range(0, text_array.size() - 1)]
		set_text(text.text)
		await Signals.text_finished
		GlobalVar.CanDropItem = true
	else:
		var text_array = GlobalVar.ReactionDialogeData[Character_id][Item_id]
		var text = text_array[randi_range(0, text_array.size() - 1)]
		Signals.SetEmote.emit(text.emotion)
		set_text(text.text)
		await Signals.text_finished
		is_end = true
		Signals.set_next_button_status.emit(true)

func result_Dialog():
	var resultData = GlobalVar.ResultDialogData[character_id][problem_id][item_id]
	set_text(resultData.text)
	await Signals.text_finished
	next_character = true
	Signals.set_next_button_status.emit(true)

func _on_next_pressed() -> void:
	Signals.set_next_button_status.emit(false)
	if is_end:
		result_Dialog()
		is_end = false
	elif next_character:
		next_character = false
		Signals.NextCharacter.emit()
	else:
		Next_Dialog(character_id, problem_id)
	
func set_next_button_status(status):
	NextButton.visible = status

func Give_Item(Item_id):
	item_id = Item_id
	Next_Dialog(character_id, problem_id, Item_id)


func _on_language_changed(_language: String) -> void:
	_apply_localization()


func _apply_localization() -> void:
	NextButton.text = Settings.localize("dialog_next")
