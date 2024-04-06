extends PlayerCharacter
class_name CPUPlayerCharacter

func _input(_event: InputEvent) -> void:
	pass


func _process(_delta: float) -> void:
	if not moving:
		moving = true
		rolled.emit(self, roll())
