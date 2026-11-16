extends Node2D

var rng = RandomNumberGenerator.new()

@onready var data_center_area = $Area2D/CollisionShape2D
@onready var data_center_count_label = $Control/Control/VBoxContainer/MarginContainer2/DataCenterCount
var data_center_scene = load("res://Scenes/transition/data_center.tscn")

var data_center_count_text = "DATA CENTERS: "
var data_center_start_spawn_delay: float = 0.5
var data_center_spawn_delay: float = 0.1

func _ready() -> void:
	data_center_count_label.text = data_center_count_text + str(Global.data_center_count)
	var data_center_area_rect = data_center_area.shape.get_rect()

	var area_min_x = data_center_area_rect.position.x
	var area_max_x = data_center_area_rect.end.x
	#print(str(area_min_x) + " " + str(area_max_x))

	var area_min_y = data_center_area_rect.position.y
	var area_max_y = data_center_area_rect.end.y
	#print(str(area_min_y) + " " + str(area_max_y))

	# Spawn already existing data centers
	for data_center_pos in Global.data_center_list:
		_spawn_data_center(data_center_pos.x, data_center_pos.y)

	await get_tree().create_timer(data_center_start_spawn_delay).timeout

	# Spawn new data centers and add them to the list
	for i in Global.data_center_count - Global.data_center_list.size():
		var random_x = rng.randf_range(area_min_x, area_max_x)
		var random_y = rng.randf_range(area_min_y, area_max_y)
		#print(str(random_x) + " " + str(random_y))

		_spawn_data_center(random_x, random_y)
		Global.data_center_list.append(Vector2(random_x, random_y))
		await get_tree().create_timer(data_center_spawn_delay).timeout

func _spawn_data_center(x, y):
	var data_center = data_center_scene.instantiate()
	$Area2D/DataCenters.add_child(data_center)
	data_center.position = Vector2(x, y)


func _on_next_day_button_pressed() -> void:
	Global._next_day()
