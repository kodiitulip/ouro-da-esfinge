extends Control
class_name MainMenu

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var play_container: PanelContainer = $PlayContainer

func _ready() -> void:
	pass


func _on_play_pressed() -> void:
	if play_container.visible:
		animation_player.play("play_popup_out")
	else:
		animation_player.play("play_popup_in")


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass
