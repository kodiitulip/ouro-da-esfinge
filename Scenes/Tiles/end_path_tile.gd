extends PathTile
class_name EndPathTile


func _stay_here(player: Character) -> void:
	player.goto = global_position
	
	player.animation_player.play("ascend")
