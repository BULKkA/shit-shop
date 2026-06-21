extends Panel

@onready var Animations : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	Signals.Start_Dialog.connect(Start_Dialog)

func _can_drop_data(position, data):
	return data is Dictionary and data.has("item_id") and GlobalVar.CanDropItem

func _drop_data(position, data):
	GlobalVar.CanDropItem = false
	Signals.Give_Item.emit(data.item_id)

func Start_Dialog(character_id):
	Animations.play(character_id + "_neutral")
