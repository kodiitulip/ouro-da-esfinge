extends Character
class_name PlayerCharacter


func _input(event: InputEvent) -> void:
	if not active_turn:
		return
	if event.is_action_pressed("roll_dice") and not moving:
		moving = true
		rolled.emit(self, await character_data.roll_dice())

