extends Node2D

var server_scene = load("res://Scenes/stacking/scenes/server.tscn")

@onready var server_count_label = $StackingUI/MarginContainer/ServerCountLabel
var server_count_text = "SERVERS LEFT: "
var servers_left = Global.server_quota

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_server_count(servers_left)

func _win_stacking():
	print("YOU WON")
	$NextSceneDelay.start()

func _on_timer_timeout() -> void:
	var server = server_scene.instantiate()
	$Servers/ServerSpawnPoint.add_child(server)

func _on_kill_box_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_stack_rack_servers_mounted(count: Variant) -> void:
	_set_server_count(Global.server_quota - count)

func _set_server_count(count: int):
	servers_left = count
	if count < 0:
		count = 0
	server_count_label.text = server_count_text + str(count)
	
	if servers_left <= 0:
		_win_stacking()


func _on_next_scene_delay_timeout() -> void:
	Global._next_scene()
