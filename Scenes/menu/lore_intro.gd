extends Node2D

var flash_count = 3

@onready var start_button = $CanvasLayer/MarginContainer/StartButton
@onready var skip_button = $CanvasLayer/MarginContainer2/SkipButton
@onready var text1 = $Texts/Text1
@onready var text2 = $Texts/Text2
@onready var text3 = $Texts/Text3

func _ready():
	text1.visible = false
	text2.visible = false
	text3.visible = false
	
	start_button.visible = false
	await get_tree().create_timer(0.5).timeout
	
	for i in flash_count:
		text3.visible = true
		await get_tree().create_timer(0.5).timeout
		text3.visible = false
		await get_tree().create_timer(0.5).timeout
		text1.visible = true
		await get_tree().create_timer(0.5).timeout
		text1.visible = false
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(0.5).timeout
	#text1.visible = true
	text2.visible = true
	await get_tree().create_timer(1).timeout
	start_button.visible = true


func _on_start_button_pressed() -> void:
	Global._start_game()


func _on_skip_button_pressed() -> void:
	Global._start_game()
