extends Node2D

var server_scene = load("res://Scenes/stacking/scenes/server.tscn")

@onready var server_count_label = $StackingUI/MarginContainer/ServerCountLabel
@onready var win_label = $StackingUI/WinLabel

var server_count_text = "SERVERS LEFT: "
var servers_left = Global.server_quota
var server_stack_wait_time: float = 1 # how long the stack must hold before winning
var has_won = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_label.visible = false
	_set_server_count(servers_left)
	Global._start_global_timer()

func _win_stacking():
	if not has_won:
		win_label.text = "HOLD..."
		win_label.visible = true
		await get_tree().create_timer(server_stack_wait_time).timeout

		if servers_left <= 0:
			has_won = true
			Global._stop_global_timer()
			win_label.text = "GOOD ENOUGH"
			$NextSceneDelay.start()
		else:
			win_label.visible = false

func _on_timer_timeout() -> void:
	var server = server_scene.instantiate()
	$Servers/ServerSpawnPoint.add_child(server)

func _on_kill_box_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_stack_rack_servers_mounted(count: Variant) -> void:
	_set_server_count(Global.server_quota - count)

func _set_server_count(count: int):
	if not has_won:
		servers_left = count
		if count < 0:
			count = 0
		server_count_label.text = server_count_text + str(count)

		if servers_left <= 0:
			_win_stacking()
	servers_left = count
	if count < 0:
		count = 0
	server_count_label.text = server_count_text + str(count)

	if servers_left <= 0:
		_win_stacking()

func _on_next_scene_delay_timeout() -> void:
	Global._next_scene()
