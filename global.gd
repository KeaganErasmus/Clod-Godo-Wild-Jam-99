extends Node

var stacking_scene = preload("res://Scenes/stacking/scenes/stacking.tscn")
var plugging_scene = preload("res://Scenes/Plugging/plugging.tscn")
var transition_scene = preload("res://Scenes/transition/transition.tscn")
var start_menu_scene = preload("res://Scenes/menu/starting_menu.tscn")

var current_scene = null
var default_scene = start_menu_scene

var day_scene_order: Array[PackedScene] = [stacking_scene]
var current_scene_index: int = 0

var dev_start_from_current_scene = false # MAKE SURE FALSE BEFORE SUBMITTING

# Transition Scene
var data_center_list: Array[Vector2] = [] # persist data center positions in transition scene

# Global Values
var days_elapsed: int = 1
var data_center_count: int = 0 # current number of data centers
var data_center_quota: int = 1 # starts at 1 and goes up
var energy_reserve: float = 100 # you lose when you run out
var energy_drain_rate: float = 1 # how much energy drains per second
var server_quota: int = 3 # starts at 3 but can go up

func _ready() -> void:
	if not dev_start_from_current_scene:
		current_scene = default_scene
		get_tree().change_scene_to_packed.call_deferred(default_scene)
	
func _start_game():
	get_tree().change_scene_to_packed.call_deferred(day_scene_order[0])
	
func _next_scene():
	current_scene_index += 1
	
	if current_scene_index >= day_scene_order.size():
		get_tree().change_scene_to_packed.call_deferred(transition_scene)
	else:
		get_tree().change_scene_to_packed.call_deferred(day_scene_order[current_scene_index])
		
func _next_day():
	days_elapsed += 1
	
	# Update Quota/Difficulty here
	
	current_scene_index = 0
	get_tree().change_scene_to_packed.call_deferred(day_scene_order[current_scene_index])
