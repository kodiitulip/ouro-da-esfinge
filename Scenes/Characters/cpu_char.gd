extends Character
class_name CPUCharacter

@onready var timer: Timer = $Timer


func _init() -> void:
	self_color = Color(randf(), randf(), randf())


func _ready() -> void:
	self_modulate = self_color


func _set_active_turn(v) -> void:
	active_turn = v
	character_data.is_turn = v
	if active_turn and not moving:
		moving = true
		rolled.emit(self, await character_data.roll_dice(6))


func rand_get_right_answer() -> bool:
	var r = randf()
	timer.start()
	await timer.timeout
	if r < 0.4:
		return true
	else:
		return false
