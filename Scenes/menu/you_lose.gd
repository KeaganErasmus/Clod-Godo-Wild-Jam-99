extends Control

@onready var start_over_button = $VBoxContainer/StartOverButton
@onready var data_center_stats_label = $MarginContainer/VBoxContainer/MarginContainer2/DataCenterStats

func _ready() -> void:
	if Global.data_center_count == 1:
		data_center_stats_label.text = "YOU BUILT " + str(Global.data_center_count) + " DATA CENTER"
	elif Global.data_center_count > 1:
		data_center_stats_label.text = "YOU BUILT " + str(Global.data_center_count) + " DATA CENTERS"

func _on_start_over_button_pressed() -> void:
	Global._start_game()
