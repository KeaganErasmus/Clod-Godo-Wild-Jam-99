extends Node

@onready var intro_music = $IntroMusic
@onready var transition_music = $TransitionMusic
@onready var gameplay_music = $GameplayMusic

@onready var music_list = [intro_music, transition_music, gameplay_music]

func _stop_all_music():
	for music in music_list:
		music.stop()

func _stop_other_music(current_music: AudioStreamPlayer):
	for music in music_list:
		if music != current_music:
			music.stop()

func _play_intro_music():
	_stop_other_music(intro_music)
	intro_music.play()

func _play_gameplay_music():
	_stop_other_music(gameplay_music)
	gameplay_music.play()
	
func _play_transition_music():
	_stop_other_music(transition_music)
	transition_music.play()
