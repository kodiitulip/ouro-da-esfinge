extends Sprite2D
class_name PathTile



@export var next_tile: PathTile
@export var prev_tile: PathTile


func move_player_to_tile(player: PlayerCharacter, roll: int) -> void:
	if roll > 0:
		if !next_tile:
			player.goto = global_position
			player.fail_move()
			return
		player.goto = next_tile.global_position
		await player.finished_moving
		player.current_tile = next_tile
		player.emit_rolled(roll - 1)
	elif roll < 0:
		if !prev_tile:
			player.goto = global_position
			player.fail_move()
			return
		player.goto = prev_tile.global_position
		await player.finished_moving
		player.current_tile = prev_tile
		player.emit_rolled(roll + 1)
	else:
		player.goto = global_position
		player.fail_move()
		return


func _on_detect_area_entered(area: Area2D) -> void:
	var obj: PathTile = area.get_parent() as PathTile
	next_tile = obj
	obj.prev_tile = self

