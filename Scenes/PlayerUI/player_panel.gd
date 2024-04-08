extends AspectRatioContainer
class_name PlayerPanel

@onready var texture_rect: TextureRect = %TextureRect
@onready var player_name: RichTextLabel = %PlayerInfo
@onready var dice: TextureRect = %Dice

@export var player_data: CharacterData:
	set = _set_data
@export var flip: bool = false:
	set = _set_flip


func _set_data(data: CharacterData) -> void:
	if player_data:
		player_data.changed.disconnect(_apply_data)
	player_data = data
	player_data.changed.connect(_apply_data)
	_apply_data()
	


func _apply_data() -> void:
	texture_rect.texture = player_data.character_icon
	texture_rect.self_modulate = player_data.character_color
	player_name.text = "%s\nPoints: %s" % [player_data.character_name, 
											player_data.points]
	if player_data.finished:
		modulate = Color(1,1,1,0.4)


func _set_flip(b: bool) -> void:
	if b:
		$HBoxContainer.layout_direction = HBoxContainer.LAYOUT_DIRECTION_RTL
	else:
		$HBoxContainer.layout_direction = HBoxContainer.LAYOUT_DIRECTION_LTR
	
	flip = b


func roll_dice(roll: int) -> void:
	var t = create_tween()
	t.tween_property(
		dice.texture, "region", 
		Rect2(
			32 * randi_range(0, 5),
			0,
			32,
			32
		),
		0.1
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property(
		dice.texture, "region", 
		Rect2(
			32 * randi_range(0, 5),
			0,
			32,
			32
		),
		0.1
	).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(
		dice.texture, "region", 
		Rect2(
			32 * randi_range(0, 5),
			0,
			32,
			32
		),
		0.1
	).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(
		dice.texture, "region", 
		Rect2(
			32 * roll,
			0,
			32,
			32
		),
		0.5
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await t.finished
