extends Sprite2D
class_name PlayerCharacter

signal rolled(player: PlayerCharacter,roll: int)

var player_data: PlayerData
var current_tile: int = 0
var goto: Vector2 = Vector2.ZERO:
	set(v):
		if global_position != v:
			goto = v


func _process(delta: float) -> void:
	if global_position.distance_to(goto) > 0.1:
		global_position = lerp(global_position, goto, delta * 2)
	else:
		global_position = goto


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("roll_dice"):
		rolled.emit(self, roll())


func roll() -> int:
	var r = randi_range(1, 4)
	print(r)
	return r
