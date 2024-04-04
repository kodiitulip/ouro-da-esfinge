extends Node2D

@onready var transition: Transition = TransitionManager as Transition

func _ready() -> void:
	transition.transition_to(transition.scenes['main_menu'])
