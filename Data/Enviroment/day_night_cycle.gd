@tool
extends CanvasModulate
class_name DayNightCycle

signal time_ticked(day: int, hour: int, minute: int)

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

@export var time_stopped: bool = false
@export var gradient: GradientTexture1D
@export var ingame_speed: float = 1.0
@export_range(0,23) var initial_hour: int = 12:
	set(h):
		initial_hour = h
		time = INGAME_TO_REAL_MINUTE_DURATION * initial_hour * MINUTES_PER_HOUR

var time: float = 0.0
var past_minute: int = -1

func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * initial_hour * MINUTES_PER_HOUR


func _process(delta: float) -> void:
	if !time_stopped:
		time += delta * INGAME_TO_REAL_MINUTE_DURATION * ingame_speed
	var sun_value = (sin(time - 0.5 * PI) + 1.0) / 2.0
	if gradient:
		color = gradient.gradient.sample(sun_value)
	
	_recalculate_time()


func _recalculate_time() -> void:
	var total_minutes: int = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	@warning_ignore("integer_division")
	var day: int = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	
	@warning_ignore("integer_division")
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_ticked.emit(day, hour, minute)
	
