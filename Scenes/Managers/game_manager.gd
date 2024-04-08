extends TileMap
class_name BoardManager

const player_char = preload("res://Scenes/Characters/player_char.tscn")
const cpu_char = preload("res://Scenes/Characters/cpu_char.tscn")
const character_data = preload("res://Data/Character/character_data.gd")

@onready var starter_path_tile: PathTile = $StarterPathTile as PathTile
@onready var end_path_tile: EndPathTile = $EndPathTile as EndPathTile
@onready var character_container: Node2D = $Players
@onready var player_ui: PlayerUI = $PlayerUI
@onready var camera: DynamicCamera2D = $DynamicCamera2D

var players: Array[Character] = []
var player_datas: Array[CharacterData] = []

func _ready() -> void:
	var p: Character = player_char.instantiate()
	var p_data: CharacterData = character_data.new()
	_setup_player(p, p_data)
	for i in range(0, 3):
		var c: Character = cpu_char.instantiate()
		var c_data: CharacterData = character_data.new()
		_setup_player(c, c_data, 'CPU')
	
	player_ui.player_datas = player_datas
	remove_child(camera)
	players[0].add_child(camera)
	players[0].active_turn = true


func _pass_the_turn(chara: Character) -> void:
	chara.active_turn = false
	chara.remove_child(camera)
	var cqueue_pos: int = players.find(chara)
	var next_in_queue: int = wrap(cqueue_pos + 1, 0, players.size())
	
	if chara.character_data.finished:
		players.remove_at(players.find(chara))
		chara.queue_free()
		next_in_queue = wrap(next_in_queue, 0, players.size())
	if players.size() > 0:
		players[next_in_queue].add_child(camera)
		players[next_in_queue].active_turn = true
	else:
		end_path_tile.add_child(camera)
		_finish_game()


func _setup_player(player: Character, data: CharacterData, 
					char_name: String = 'Player') -> void:
	data.character_name = char_name
	data.character_color = player.self_color
	player.character_data = data
	character_container.add_child(player)
	player.current_tile = starter_path_tile
	player.global_position = starter_path_tile.global_position
	player.rearange_in_tile(starter_path_tile.rearenge_in_tile(player))
	player.turn_ended.connect(_pass_the_turn)
	players.append(player)
	player_datas.append(data)


func _finish_game() -> void:
	pass
