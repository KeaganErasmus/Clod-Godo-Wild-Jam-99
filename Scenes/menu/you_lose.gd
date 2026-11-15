extends Control

@onready var start_over_button = $VBoxContainer/StartOverButton



func _on_start_over_button_pressed() -> void:
	Global._start_game()
