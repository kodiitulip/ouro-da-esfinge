extends CanvasLayer
class_name PlayerUI

#const player_panel: PackedScene = preload("res://Scenes/PlayerUI/player_panel.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var top_left: PlayerPanel = %TopLeft as PlayerPanel
@onready var top_right: PlayerPanel = %TopRight as PlayerPanel
@onready var bottom_right: PlayerPanel = %BottomRight as PlayerPanel
@onready var bottom_left: PlayerPanel = %BottomLeft as PlayerPanel


@export var player_datas: Array[PlayerData] = []:
	set(d):
		if d.size() > 4:
			d.resize(4)
		player_datas = d

func _ready() -> void:
	if player_datas.is_empty():
		printerr('player_datas is empty!')
		return
	
	top_left.player_data = player_datas[0]
	top_right.player_data = player_datas[1]
	bottom_left.player_data = player_datas[2]
	bottom_right.player_data = player_datas[3]
	
	fade_in()


func fade_in() -> void:
	animation_player.play_backwards("fade")


func fade_out() -> void:
	animation_player.play("fade")
