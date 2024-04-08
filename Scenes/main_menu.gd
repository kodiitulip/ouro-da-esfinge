extends Control
class_name MainMenu


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var play_container: PanelContainer = $PlayContainer
@onready var fullscreen: CheckBox = %Fullscreen

var transition: Transition = TransitionManager as Transition


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		fullscreen.button_pressed = true


func _on_play_pressed() -> void:
	if play_container.visible:
		animation_player.play_backwards("play_popup")
	else:
		animation_player.play("play_popup")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_singleplayer_pressed() -> void:
	transition.transition_to(transition.scenes['board'])


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
