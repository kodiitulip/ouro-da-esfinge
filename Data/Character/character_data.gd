extends Resource
class_name CharacterData

@export var character_name: String = "PlayerName"
@export var character_icon: Texture2D = preload("res://Assets/Characters/char.png")
@export var character_color: Color = Color(1,1,1,1)
@export var character_id: int

var ui: PlayerPanel
var points = 0:
	set(p):
		points = p
		emit_changed()
var is_turn: bool = false
var finished: bool
var questions: int = 0


func roll_dice(m: int = 6) -> int:
	var r = randi_range(1, m)
	print(r)
	if ui:
		await ui.roll_dice(r - 1)
	return r
