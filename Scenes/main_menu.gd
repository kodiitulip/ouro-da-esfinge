extends Control
class_name MainMenu


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fullscreen: CheckBox = %Fullscreen

var transition: Transition = TransitionManager as Transition


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		fullscreen.button_pressed = true


func _on_play_pressed() -> void:
	transition.transition_to(transition.scenes['board'])


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_credits_pressed() -> void:
	animation_player.play("credits")


func _on_close_credits_pressed() -> void:
	animation_player.play_backwards("credits")
