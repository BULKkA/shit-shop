extends TextureRect

const ItemImagePath = "res://_art/Items/"

var item_id = ""

func setup(Item_id):
	self.texture = load(ItemImagePath + Item_id + ".png")
	self.item_id = Item_id

func _get_drag_data(at_position: Vector2) -> Variant:
	var root := Control.new()
	var preview := TextureRect.new()
	preview.texture = self.texture

	var preview_size := self.size
	preview.size = preview_size
	preview.offset_transform_enabled = true
	preview.offset_transform_scale.x = 0.6
	preview.offset_transform_scale.y = 0.6
	preview.custom_minimum_size = preview_size
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.position = -preview_size / 2.0
	root.add_child(preview)
	set_drag_preview(root)
	visible = false
	return {
		"item_id": item_id
	}

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		visible = true
