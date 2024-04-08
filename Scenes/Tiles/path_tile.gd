extends Sprite2D
class_name PathTile

var map

var offsets = [
	{
		"player": null,
		"pos": Vector2(7, -5)
	},
	{
		"player": null,
		"pos":Vector2(-7, -5)
	},
	{
		"player": null,
		"pos":Vector2(7, 5)
	},
	{
		"player": null,
		"pos":Vector2(-7, 5)
	},
]


@export var next_tile: PathTile
@export var prev_tile: PathTile


func _ready() -> void:
	map = get_tree().get_first_node_in_group("board")


func move_player_to_tile(player: Character, roll: int) -> void:
	if roll > 0:
		if !next_tile:
			_stay_here(player)
			return
		_leave_here(player, roll, false)
	elif roll < 0:
		if !prev_tile:
			_stay_here(player)
			return
		_leave_here(player, roll, true)
	else:
		_stay_here(player)


func _stay_here(player: Character) -> void:
	player.goto = global_position
	player.fail_move(rearenge_in_tile(player))


func rearenge_in_tile(player: Character) -> Vector2:
	var place: Vector2
	for pl in offsets:
		if pl["player"] == null:
			place = pl["pos"]
			pl["player"] = player
			return place
	return Vector2.ZERO


func _leave_here(player: Character, roll: int, prev: bool) -> void:
	var tile_to_move
	var new_roll
	
	if prev:
		tile_to_move = prev_tile
		new_roll = roll + 1
	else:
		tile_to_move = next_tile
		new_roll = roll - 1
	
	for pl in offsets:
		if pl["player"] == player:
			pl["player"] = null
			break
	
	player.goto = tile_to_move.global_position
	await player.finished_moving
	player.current_tile = tile_to_move
	player.emit_rolled(new_roll)


func _on_detect_area_entered(area: Area2D) -> void:
	var obj: PathTile = area.get_parent() as PathTile
	next_tile = obj
	obj.prev_tile = self

