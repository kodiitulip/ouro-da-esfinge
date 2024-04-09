extends Control
class_name ArielScreen

const dialog_file = "res://Data/Dialog/dialog.json"
const ariel_poses = [
	preload("res://Assets/Ariel/Ativo 12-8.png"),
	preload("res://Assets/Ariel/Ativo 11-8.png"),
	preload("res://Assets/Ariel/Ativo 10-8.png"),
	preload("res://Assets/Ariel/Ativo 9-8.png"),
]

@onready var dialog_label: RichTextLabel = %DialogLabel
@onready var portrait: TextureRect = %Portrait

var dialog_lines: Dictionary
var current_lines: Array = [
	"if you seeing this something broke"
]
var current_line_number: int = 0
var transition: Transition = TransitionManager as Transition
var ending: bool = false

func _ready() -> void:
	_read_file()


func _read_file() -> void:
	var file_as_string = FileAccess.get_file_as_string(dialog_file)
	var file_as_json = JSON.parse_string(file_as_string)
	
	dialog_lines = file_as_json as Dictionary


func show_starting_dialog() -> void:
	show()
	if !dialog_lines:
		return
	current_lines = dialog_lines["opening-dialog"]
	_set_text_at_line(current_line_number)


func show_ending_dialog() -> void:
	show()
	if !dialog_lines:
		return
	current_lines = dialog_lines["ending-dialog"]
	_set_text_at_line(current_line_number)
	ending = true


func show_wrong_answer_dialog() -> void:
	show()
	if !dialog_lines:
		return
	var l = dialog_lines["wrong-answer"] as Array[Array]
	current_lines = l.pick_random()
	_set_text_at_line(current_line_number)


func show_right_answer_dialog() -> void:
	show()
	if !dialog_lines:
		return
	var l = dialog_lines["right-answer"] as Array[Array]
	current_lines = l.pick_random()
	_set_text_at_line(current_line_number)


func _set_text_at_line(linenum: int) -> void:
	dialog_label.text = current_lines[linenum]
	portrait.texture = ariel_poses.pick_random()


func _on_next_button_pressed() -> void:
	current_line_number += 1
	if current_line_number > current_lines.size() - 1:
		current_line_number = 0
		hide()
		if ending:
			transition.transition_to(transition.scenes['main_menu'])
	else:
		_set_text_at_line(current_line_number)
	
