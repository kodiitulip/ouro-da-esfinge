extends Sprite2D
class_name PlayerCharacter

signal rolled(player: PlayerCharacter,roll: int)
signal finished_moving()
signal turn_ended()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_data: PlayerData
var current_tile: PathTile:
	set = connect_to_tile
var goto: Vector2 = Vector2.ZERO:
	set = _move
var moving: bool = false


func _move(v) -> void:
	if goto == v:
		return
	goto = v
	animation_player.play("move")
	await animation_player.animation_finished
	var t = create_tween()
	
	t.tween_property(self, "global_position", goto, 0.4
	).set_ease(Tween.EASE_IN_OUT).from_current()
	
	await t.finished
	t.kill()
	animation_player.play_backwards("move")
	await animation_player.animation_finished
	finished_moving.emit()



func connect_to_tile(tile: PathTile) -> void:
	if current_tile:
		rolled.disconnect(current_tile.move_player_to_tile)
	rolled.connect(tile.move_player_to_tile)
	current_tile = tile


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("roll_dice") and not moving:
		moving = true
		rolled.emit(self, roll())


func roll() -> int:
	var r = randi_range(1, 4)
	print(r)
	return r


func emit_rolled(new_roll: int) -> void:
	rolled.emit(self, new_roll)


func fail_move() -> void:
	animation_player.play("fail_move")
	moving = false
	turn_ended.emit()
