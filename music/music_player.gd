extends Node

@onready var intro_music = $IntroMusic
@onready var transition_music = $TransitionMusic
@onready var gameplay_music = $GameplayMusic
@onready var you_lose_music = $YouLoseMusic
@onready var button_click = $ButtonClick

@onready var music_list = [intro_music, transition_music, gameplay_music, you_lose_music]

func _stop_all_music():
	for music in music_list:
		music.stop()

func _stop_other_music(current_music: AudioStreamPlayer):
	for music in music_list:
		if music != current_music:
			music.stop()

func _play_intro_music():
	intro_music.play()
	_stop_other_music(intro_music)


func _play_gameplay_music():
	gameplay_music.play()
	_stop_other_music(gameplay_music)

func _play_transition_music():
	transition_music.play()
	_stop_other_music(transition_music)
	
func _play_you_lose_music():
	you_lose_music.play()
	_stop_other_music(you_lose_music)

func _set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(volume))
	
func _get_music_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(0))

func _play_button_click() -> void:
	button_click.play()
