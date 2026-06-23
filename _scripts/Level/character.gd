extends Panel

@onready var Animations : AnimatedSprite2D = $AnimatedSprite2D
var character_id
var receive_item_tween: Tween
var default_position: Vector2
var default_scale: Vector2

func _ready() -> void:
	default_position = Animations.position
	default_scale = Animations.scale
	Signals.Start_Dialog.connect(Start_Dialog)
	Signals.SetEmote.connect(SetEmote)

func _can_drop_data(position, data):
	return data is Dictionary and data.has("item_id") and GlobalVar.CanDropItem

func _drop_data(position, data):
	GlobalVar.CanDropItem = false
	_play_receive_item_animation()
	Signals.Give_Item.emit(data.item_id)

func Start_Dialog(Сharacter_id, Problem_id):
	character_id = Сharacter_id
	Animations.play(character_id + "_neutral")
	Signals.Play_Sound.emit(Sounds.Type.Music, Сharacter_id)

func SetEmote(emote_id):
	Animations.play(character_id + "_" + emote_id)


func _play_receive_item_animation() -> void:
	if receive_item_tween:
		receive_item_tween.kill()

	Animations.position = default_position
	Animations.scale = default_scale

	receive_item_tween = create_tween()
	receive_item_tween.set_parallel(true)
	receive_item_tween.tween_property(
		Animations,
		"position",
		default_position + Vector2(0.0, -18.0),
		0.14
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	receive_item_tween.tween_property(
		Animations,
		"scale",
		default_scale * 1.035,
		0.14
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	receive_item_tween.chain().set_parallel(true)
	receive_item_tween.tween_property(
		Animations,
		"position",
		default_position,
		0.22
	).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	receive_item_tween.tween_property(
		Animations,
		"scale",
		default_scale,
		0.22
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
