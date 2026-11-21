extends CanvasLayer

func _ready() -> void:
	$MarginContainer/VBoxContainer/MusicVolume.value = 1
	Global._set_music_volume($MarginContainer/VBoxContainer/MusicVolume.value)

func _on_button_pressed() -> void:
	MusicPlayer._play_button_click()
	Global._play_lore_scene()


func _on_music_volume_value_changed(value: float) -> void:
	Global._set_music_volume(value)
