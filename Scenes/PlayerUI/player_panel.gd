extends AspectRatioContainer
class_name PlayerPanel

@onready var texture_rect: TextureRect = %TextureRect
@onready var player_name: RichTextLabel = %PlayerName

@export var player_data: PlayerData:
	set = set_data
@export var flip: bool = false:
	set = set_flip


func set_data(data: PlayerData) -> void:
	player_data = data
	texture_rect.texture = player_data.player_icon
	player_name.text = player_data.player_name

func set_flip(b: bool) -> void:
	if b:
		$HBoxContainer.layout_direction = HBoxContainer.LAYOUT_DIRECTION_RTL
	else:
		$HBoxContainer.layout_direction = HBoxContainer.LAYOUT_DIRECTION_LTR
	
	flip = b
