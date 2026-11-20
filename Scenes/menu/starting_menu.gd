extends CanvasLayer

func _ready() -> void:
	$MusicVolume.value = 1
	Global._set_music_volume($MusicVolume.value)

func _on_button_pressed() -> void:
	Global._start_game()


func _on_music_volume_value_changed(value: float) -> void:
	Global._set_music_volume(value)
