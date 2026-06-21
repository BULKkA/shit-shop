extends Control

@onready var hbox: HBoxContainer = $Panel/HBoxContainer
var items_list : Dictionary

func _ready() -> void:
	Signals.Give_Item.connect(remove_item)
	Signals.LoadItemField.connect(LoadItemField)

func add_item(item_id):
	var item = GlobalVar.ItemScene.instantiate()
	hbox.add_child(item)
	items_list[item_id] = item
	item.setup(item_id)

func remove_item(item_id):
	items_list[item_id].queue_free()
	items_list.erase(item_id)

func LoadItemField(item_list):
	for item in item_list:
		add_item(item)
