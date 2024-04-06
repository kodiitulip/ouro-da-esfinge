extends Camera2D
class_name DynamicCamera2D

const MAX_DISTANCE = 20

var target_distance: float = 0.0
var center_pos: Vector2 = position

func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = 2
	zoom = Vector2(2, 2)


func _process(_delta: float) -> void:
	var direction: Vector2 = center_pos.direction_to(get_local_mouse_position())
	var target_pos: Vector2 = center_pos + direction * target_distance
	
	target_pos = target_pos.clamp(
		center_pos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_pos + Vector2(MAX_DISTANCE, MAX_DISTANCE)
	)
	
	position = target_pos


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_distance = center_pos.distance_to(get_local_mouse_position() / 2)
