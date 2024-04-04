extends Control
class_name MainMenu


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var play_container: PanelContainer = $PlayContainer

var transition: Transition = TransitionManager as Transition


func _on_play_pressed() -> void:
	if play_container.visible:
		animation_player.play_backwards("play_popup")
	else:
		animation_player.play("play_popup")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_singleplayer_pressed() -> void:
	transition.transition_to(transition.scenes['board'])


func _on_fullscreen_pressed() -> void:
	pass # Replace with function body.
