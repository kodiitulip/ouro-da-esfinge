extends TileMap
class_name BoardManager

const player_char = preload("res://Scenes/Characters/char.tscn")
const player_data = preload("res://Data/Player/player_data.gd")

const tiles: Array[Vector2i] = [
	Vector2i(-2, 7),
	Vector2i(-1, 6),
	Vector2i(-1, 5),
	Vector2i(0, 4),
	Vector2i(0, 3),
	Vector2i(1, 2),
]

@onready var player_container: Node2D = $Players

func _ready() -> void:
	for i in range(0, 1):
		var p: PlayerCharacter = player_char.instantiate()
		var p_data: PlayerData = player_data.new()
		p_data.player_name = "Player"
		p.player_data = p_data
		player_container.add_child(p)
		move_dice_number(p, 0)
		p.rolled.connect(move_dice_number)


func move_dice_number(player: PlayerCharacter, roll: int) -> void:
	var ptile: int = player.current_tile
	var ntile = (ptile + roll)
	player.goto = map_to_local(tiles[ntile])
	player.current_tile += roll
