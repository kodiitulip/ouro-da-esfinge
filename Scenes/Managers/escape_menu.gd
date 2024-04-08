extends CanvasLayer
class_name EscapeMenu

@onready var center_container: CenterContainer = $CenterContainer
@onready var continue_button: Button = %Continue
@onready var fullscreen: CheckBox = %Fullscreen
@onready var menu_button: Button = %Menu
@onready var quit_button: Button = %Quit

@export var player_ui: PlayerUI

var transition: Transition = TransitionManager as Transition
var active: bool = false:
	set(value):
		active = value
		center_container.visible = active
		fade_ui()
		


func fade_ui() -> void:
	if player_ui:
		player_ui.fade_out() if active else player_ui.fade_in()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		active = !active
	if event.is_action_pressed("fullscreen"):
		fullscreen.button_pressed = true


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
