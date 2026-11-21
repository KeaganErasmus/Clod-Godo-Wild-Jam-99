extends Node2D

var rng = RandomNumberGenerator.new()

@onready var drill_machine = $DrillBody
@onready var water_area = $Area2D/WaterArea
@onready var win_label = $WinLabel
var water_bottle_scene: PackedScene = load("res://Scenes/digging/scenes/water_bottle.tscn")
var water_count: int = 0
var won = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_label.visible = false
	var water_area_rect = water_area.shape.get_rect()

	var area_min_x = water_area_rect.position.x
	var area_max_x = water_area_rect.end.x
	#print(str(area_min_x) + " " + str(area_max_x))

	var area_min_y = water_area_rect.position.y
	var area_max_y = water_area_rect.end.y

	for i in Global.water_quota:
		var random_x = rng.randf_range(area_min_x, area_max_x)
		var random_y = rng.randf_range(area_min_y, area_max_y)

		var water_bottle = water_bottle_scene.instantiate()
		water_bottle.connect('water_hit', _on_water_hit)
		$Area2D/Waters.add_child(water_bottle)
		water_bottle.position = Vector2(random_x, random_y)
		var random_scale = rng.randf_range(1.0, 3.0)
		water_bottle.scale = Vector2(random_scale, random_scale)
		water_bottle.rotation = rng.randf_range(0,360)

	Global._start_global_timer()

func _process(delta: float) -> void:
	if water_count >= Global.water_quota and not won:
		won = true
		MusicPlayer.diggin_sound.set_playing(false)
		_win_digging()

func _on_water_hit():
	MusicPlayer._play_bottle_crunch_sound()
	water_count += 1

func _win_digging():
	win_label.visible = true
	Global._stop_global_timer()
	$WinDelayTimer.start()

func _on_win_delay_timer_timeout() -> void:
	Global._next_scene()
