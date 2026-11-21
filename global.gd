extends Node

var stacking_scene = preload("res://Scenes/stacking/scenes/stacking.tscn")
var plugging_scene = preload("res://Scenes/Plugging/plugging.tscn")
var transition_scene = preload("res://Scenes/transition/transition.tscn")
var start_menu_scene = preload("res://Scenes/menu/starting_menu.tscn")
var you_lose_scene = preload("res://Scenes/menu/you_lose.tscn")
var digging_scene = preload("res://Scenes/digging/scenes/digging.tscn")
var chopping_scene = preload("res://Scenes/Chopping/chopping.tscn")
var lore_scene = preload("res://Scenes/menu/lore_intro.tscn")

var default_scene = start_menu_scene

var day_scene_order: Array[PackedScene]
var current_scene_index: int

var dev_start_from_current_scene = true # MAKE SURE FALSE BEFORE SUBMITTING

# Transition Scene
var data_center_list: Array[Vector2] = [] # persist data center positions in transition scene

# Global Values
var days_elapsed: int
var data_center_count: int # current number of data centers
var data_center_quota: int # how many data centers need to be completed
var max_time_left: float
var timer_drain_rate: float
var current_time_left: float # you lose when you run out
var server_quota: int
var is_timer_active: bool
var water_quota: int
var tree_quota: int

# Difficulty Values
var time_increase_multiplier: float = 0.1 # 0.1 = +10% time per round
var difficulty_multiplier: float = 0.20

func _reset_global_variables():
	day_scene_order = [chopping_scene, digging_scene, stacking_scene, plugging_scene]
	current_scene_index = 0
	data_center_list = [] # persist data center positions in transition scene
	days_elapsed = 1
	data_center_count = 0 # current number of data centers
	data_center_quota = 1 # how many data centers need to be completed
	max_time_left = 60
	timer_drain_rate = 1
	current_time_left = max_time_left # you lose when you run out
	server_quota = 3
	is_timer_active = false
	water_quota = 3
	tree_quota = 3


func _ready() -> void:
	_reset_global_variables()
	Global._reset_global_timer()
	if not dev_start_from_current_scene:
		get_tree().change_scene_to_packed.call_deferred(default_scene)
	MusicPlayer._play_intro_music()

func _process(delta: float) -> void:
	if is_timer_active:
		_run_global_timer(delta)

func _start_game():
	_reset_global_variables()
	get_tree().change_scene_to_packed.call_deferred(day_scene_order[0])
	MusicPlayer._play_gameplay_music()

func _play_lore_scene():
	get_tree().change_scene_to_packed.call_deferred(lore_scene)

func _next_scene():
	current_scene_index += 1

	if current_scene_index >= day_scene_order.size():
		data_center_count += 1

	# you completed the day quota
	if current_scene_index >= day_scene_order.size() and data_center_count >= data_center_quota:
		get_tree().change_scene_to_packed.call_deferred(transition_scene)
		MusicPlayer._play_transition_music()

	# you created a data center but haven't met quota
	elif current_scene_index >= day_scene_order.size() and data_center_count <= data_center_quota:
		current_scene_index = 0
		get_tree().change_scene_to_packed.call_deferred(day_scene_order[0])

	# next task
	else:
		get_tree().change_scene_to_packed.call_deferred(day_scene_order[current_scene_index])

func _next_day():
	days_elapsed += 1

	### Update Quota/Difficulty here
	data_center_quota += 1
	#data_center_quota += days_elapsed

	max_time_left += max_time_left * time_increase_multiplier

	_reset_global_timer()

	server_quota += round(server_quota * difficulty_multiplier)
	water_quota += round(water_quota * difficulty_multiplier)
	tree_quota += round(tree_quota * difficulty_multiplier)

	current_scene_index = 0
	get_tree().change_scene_to_packed.call_deferred(day_scene_order[current_scene_index])
	MusicPlayer._play_gameplay_music()

func _run_global_timer(delta: float):
	current_time_left -= timer_drain_rate * delta
	#print(current_time_left)
	if current_time_left <= 0:
		_stop_global_timer()
		_lose_game()

func _reset_global_timer():
	is_timer_active = false
	current_time_left = max_time_left

func _start_global_timer():
	is_timer_active = true

func _stop_global_timer():
	is_timer_active = false

func _lose_game():
	get_tree().change_scene_to_packed.call_deferred(you_lose_scene)
	MusicPlayer._play_you_lose_music()

func _set_music_volume(value: float) -> void:
	MusicPlayer._set_music_volume(value)

########################################
###          GLOBAL SIGNALS          ###
########################################
signal tree_killed
