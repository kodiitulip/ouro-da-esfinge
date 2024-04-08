extends Sprite2D
class_name Character

signal rolled(character: Character, roll: int)
signal finished_moving()
signal turn_ended(character: Character)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var self_color: Color = Color(1,1,1)
var character_data: CharacterData
var current_tile: PathTile:
	set = connect_to_tile
var goto: Vector2 = Vector2.ZERO:
	set = _move
var active_turn: bool = false:
	set = _set_active_turn
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


func emit_rolled(new_roll: int) -> void:
	if !active_turn:
		return
	rolled.emit(self, new_roll)


func fail_move(off: Vector2 = Vector2.ZERO) -> void:
	animation_player.play("fail_move")
	await animation_player.animation_finished
	rearange_in_tile(off)
	moving = false
	turn_ended.emit(self)


func rearange_in_tile(off: Vector2) -> void:
	var t = create_tween()
	t.tween_property(self, "global_position", global_position + off, 0.15
	).from_current()


func _set_active_turn(v) -> void:
	active_turn = v
	character_data.is_turn = v


func _ascend() -> void:
	character_data.finished = true
	moving = false
	turn_ended.emit(self)
