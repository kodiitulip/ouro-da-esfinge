extends CanvasLayer
class_name PlayerUI

const sphinx_card = preload("res://Scenes/PlayerUI/Cards/sphinx_card.tscn")
const trap_card = preload("res://Scenes/PlayerUI/Cards/trap_card.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var top_left: PlayerPanel = %TopLeft as PlayerPanel
@onready var top_right: PlayerPanel = %TopRight as PlayerPanel
@onready var bottom_right: PlayerPanel = %BottomRight as PlayerPanel
@onready var bottom_left: PlayerPanel = %BottomLeft as PlayerPanel
@onready var ariel_screen: ArielScreen = $"ArielScreen" as ArielScreen


@export var player_datas: Array[CharacterData] = []:
	set(d):
		if d.size() > 4:
			d.resize(4)
		player_datas = d
		if d.size() == 4:
			_place_character_datas()


func _place_character_datas() -> void:
	top_left.player_data = player_datas[0]
	player_datas[0].ui = top_left
	top_right.player_data = player_datas[1]
	player_datas[1].ui = top_right
	bottom_left.player_data = player_datas[2]
	player_datas[2].ui = bottom_left
	bottom_right.player_data = player_datas[3]
	player_datas[3].ui = bottom_right


func fade_in() -> void:
	animation_player.play_backwards("fade")


func fade_out() -> void:
	animation_player.play("fade")


func show_sphinx_card(player: PlayerCharacter, place: Vector2 = Vector2.ZERO) -> void:
	var card = sphinx_card.instantiate() as SphinxCard
	card.ui = self
	card.player = player
	card.player_pos = place
	add_child(card)


func show_trap_card(player: PlayerCharacter, place: Vector2 = Vector2.ZERO) -> void:
	var card = trap_card.instantiate() as TrapCard
	card.ui = self
	card.player = player
	card.player_pos = place
	add_child(card)


func _on_roll_button_pressed() -> void:
	var p = InputEventAction.new()
	p.action = "roll_dice"
	p.pressed = true
	p.strength = 1
	Input.parse_input_event(p)


func _on_esc_button_pressed() -> void:
	var p = InputEventAction.new()
	p.action = "escape"
	p.pressed = true
	p.strength = 1
	Input.parse_input_event(p)
