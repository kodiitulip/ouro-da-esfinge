extends Control
class_name SphinxCard

const questions = "res://Data/Questions/perguntas.json"

@onready var pergunta: RichTextLabel = %Pergunta
@onready var answer_1: Button = %Answer1
@onready var answer_2: Button = %Answer2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player: PlayerCharacter
var player_pos: Vector2 = Vector2.ZERO
var f: bool = false
var perguntas: Dictionary
var ui: PlayerUI

@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_read_questions_file()
	_generate("sphinx")
	animation_player.play("flip")
	AudioServer.set_bus_volume_db(1, -10)
	audio_stream.finished.connect(_loop_song)


func _loop_song() -> void:
	audio_stream.play()


func _generate(type: String = "sphinx") -> void:
	var quest = {
		"question": "[debug] if you see this something is broken",
		"answer1": "1",
		"answer2": "2",
		"correct": "answer2",
	}
	if perguntas:
		quest = perguntas[type].pick_random()
	pergunta.text = quest["question"]
	answer_1.text = "A. %s" % quest["answer1"]
	answer_2.text = "B. %s" % quest["answer2"]
	_connect_buttons(quest)


func _connect_buttons(quest: Dictionary) -> void:
	if quest["correct"] == "answer1":
		answer_1.pressed.connect(_on_right_answer_pressed)
		answer_2.pressed.connect(_on_wrong_answer_pressed)
	elif quest["correct"] == "answer2":
		answer_1.pressed.connect(_on_wrong_answer_pressed)
		answer_2.pressed.connect(_on_right_answer_pressed)


func _read_questions_file() -> void:
	var json_as_text = FileAccess.get_file_as_string(questions)
	var json_as_dic = JSON.parse_string(json_as_text)
	if json_as_dic:
		perguntas = json_as_dic


func _on_right_answer_pressed() -> void:
	if !player:
		ui.remove_child(self)
		queue_free()
		return
	player.character_data.points += 2
	player.character_data.questions += 1
	animation_player.play_backwards("flip")
	await animation_player.animation_finished
	player.fail_move(player_pos)
	ui.remove_child(self)
	ui.ariel_screen.show_right_answer_dialog()
	AudioServer.set_bus_volume_db(1, 0)
	queue_free()


func _on_wrong_answer_pressed() -> void:
	if !player:
		ui.remove_child(self)
		queue_free()
		return
	animation_player.play_backwards("flip")
	await animation_player.animation_finished
	player.fail_move(player_pos)
	ui.remove_child(self)
	ui.ariel_screen.show_wrong_answer_dialog()
	AudioServer.set_bus_volume_db(1, 0)
	queue_free()
