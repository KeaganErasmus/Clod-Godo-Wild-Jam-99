extends Node

@onready var intro_music = $IntroMusic
@onready var transition_music = $TransitionMusic
@onready var gameplay_music = $GameplayMusic
@onready var you_lose_music = $YouLoseMusic
@onready var button_click = $ButtonClick
@onready var eth_click = $EthClick
@onready var wrong_effect = $WrongEffect
@onready var shoot_effect = $ShootEffect
@onready var crack_effect = $CrackEffect
@onready var car_sound = $CarSound
@onready var drill_shot = $DrillShot
@onready var diggin_sound = $DiggingSound
@onready var bottle_crunch_sound = $BottleCrunchSound
@onready var water_splash_sound = $WaterSplash
@onready var gravel_sound = $GravelSound
@onready var magnet_effect = $MagnetEffect
@onready var launcher_sound = $LauncherSound
@onready var ah_sound = $AHSound

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

func _play_eth_click() -> void:
	eth_click.play()

func _play_wrong_effec() -> void:
	wrong_effect.play()

func _play_shoot_effect() -> void:
	shoot_effect.play()

func _play_crack_effec() -> void:
	crack_effect.play()

func _play_car_sound() -> void:
	car_sound.play()

func _play_drill_shot() -> void:
	drill_shot.play()

func _play_digging_sound() -> void:
	diggin_sound.play()

func _play_bottle_crunch_sound() -> void:
	bottle_crunch_sound.play()

func _play_water_splash_sound() -> void:
	water_splash_sound.play()

func _play_gravel_sound() -> void:
	gravel_sound.play()

func _play_magnet_effect() -> void:
	magnet_effect.play()

func _play_launcher_sound() -> void:
	launcher_sound.play()

func _play_ah_sound() -> void:
	ah_sound.play()
