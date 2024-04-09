extends CanvasLayer
class_name EscapeMenu

@onready var center_container: CenterContainer = $CenterContainer
@onready var continue_button: Button = %Continue
@onready var fullscreen: CheckBox = %Fullscreen
@onready var menu_button: Button = %Menu
@onready var quit_button: Button = %Quit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var player_ui: PlayerUI

var transition: Transition = TransitionManager as Transition
var active: bool = true:
	set(value):
		active = value
		center_container.visible = active
		fade_ui()
		


func fade_ui() -> void:
	if player_ui:
		player_ui.fade_out() if active else player_ui.fade_in()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if $HelpMenu.visible:
			animation_player.play_backwards("help")
			await animation_player.animation_finished
		elif $CreditsMenu.visible:
			animation_player.play_backwards("credits")
			await animation_player.animation_finished
		else:
			active = !active


func _on_continue_pressed() -> void:
	active = false


func _on_menu_pressed() -> void:
	transition.transition_to(transition.scenes['main_menu'])
	active = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_help_pressed() -> void:
	animation_player.play("help")


func _on_close_help_pressed() -> void:
	animation_player.play_backwards("help")


func _on_credits_pressed() -> void:
	animation_player.play("credits")


func _on_close_credits_pressed() -> void:
	animation_player.play_backwards("credits")
