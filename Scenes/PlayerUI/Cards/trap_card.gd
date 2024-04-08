extends SphinxCard
class_name TrapCard


func _ready() -> void:
	_read_questions_file()
	_generate("traps")
	animation_player.play("flip")


func _on_right_answer_pressed() -> void:
	if !player:
		get_parent().remove_child(self)
		queue_free()
		return
	player.character_data.points += 1
	animation_player.play_backwards("flip")
	await animation_player.animation_finished
	player.fail_move(player_pos)
	get_parent().remove_child(self)
	queue_free()


func _on_wrong_answer_pressed() -> void:
	if !player:
		get_parent().remove_child(self)
		queue_free()
		return
	animation_player.play_backwards("flip")
	await animation_player.animation_finished
	player.emit_rolled(randi_range(-4,-2))
	get_parent().remove_child(self)
	queue_free()
