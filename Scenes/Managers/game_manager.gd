extends TileMap
class_name BoardManager

const player_char = preload("res://Scenes/Characters/char.tscn")
const cpu_char = preload("res://Scenes/Characters/cpu_char.tscn")
const player_data = preload("res://Data/Player/player_data.gd")

@onready var starter_path_tile: PathTile = $StarterPathTile as PathTile
@onready var player_container: Node2D = $Players

var players: Array[PlayerCharacter] = []

func _ready() -> void:
	var p: PlayerCharacter = player_char.instantiate()
	var p_data: PlayerData = player_data.new()
	p_data.player_name = "Player"
	p.player_data = p_data
	player_container.add_child(p)
	p.current_tile = starter_path_tile
	p.emit_rolled(0)
	players.append(p)
	
	for i in range(0, 2):
		var c: PlayerCharacter = cpu_char.instantiate()
		var c_data: PlayerData = player_data.new()
		c_data.player_name = "CPU"
		c.player_data = c_data
		player_container.add_child(c)
		c.current_tile = starter_path_tile
		c.emit_rolled(1)
