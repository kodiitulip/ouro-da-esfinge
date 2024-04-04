extends CanvasLayer
class_name Transition

const scenes: Dictionary = {
	"board": "res://Scenes/board.tscn",
	"main_menu": "res://Scenes/main_menu.tscn",
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $ProgressBar

var scene_container: Node
var progress: Array[float] = []
var scene_name: String
var scene_load_status: int = 0
var new_loaded_scene: Resource
var transitioning: bool = false:
	set(value):
		transitioning = value
		set_process(value)

func _ready() -> void:
	scene_container = get_tree().get_first_node_in_group("scene_container")


func transition_to(scenename: String) -> void:
	scene_name = scenename
	animation_player.play("transition_in")


func _request_load() -> void:
	if scene_container.get_child_count() > 0:
		scene_container.get_child(0).queue_free()
	ResourceLoader.load_threaded_request(scene_name)
	transitioning = true


func _process(_delta: float) -> void:
	if !transitioning:
		return
	
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name, progress)
	progress_bar.value = progress[0]
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		new_loaded_scene = ResourceLoader.load_threaded_get(scene_name)
		animation_player.play("transition_out")


func _finish_transition() -> void:
	if !new_loaded_scene:
		printerr('scene has not loaded!')
		return
	
	if new_loaded_scene is PackedScene:
		scene_container.add_child(new_loaded_scene.instantiate())
	
	transitioning = false
