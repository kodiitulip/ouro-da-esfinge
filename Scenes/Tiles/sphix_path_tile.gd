extends PathTile
class_name SphinxPathTile

func _stay_here(player: Character) -> void:
	player.goto = global_position
	if player is PlayerCharacter:
		map.player_ui.show_sphinx_card(player, rearenge_in_tile(player))
	elif player is CPUCharacter:
		var b = await player.rand_get_right_answer()
		if b:
			player.character_data.points += 2
		player.fail_move(rearenge_in_tile(player))
