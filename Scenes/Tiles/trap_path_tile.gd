extends PathTile
class_name TrapPathTile

func _stay_here(player: Character) -> void:
	player.goto = global_position
	if player is PlayerCharacter:
		map.player_ui.show_trap_card(player, rearenge_in_tile(player))
	elif player is CPUCharacter:
		var b = await player.rand_get_right_answer()
		if b:
			player.character_data.points += 1
			player.fail_move(rearenge_in_tile(player))
		else:
			player.emit_rolled(randi_range(-4, -2))
