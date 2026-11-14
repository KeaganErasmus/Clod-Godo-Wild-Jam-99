extends Node2D

var server_scene = load("res://Scenes/stacking/scenes/server.tscn")

var server_quota: int = 5
@onready var server_count_label = $StackingUI/MarginContainer/ServerCountLabel
var server_count_text = "SERVERS LEFT: "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_server_count(server_quota)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var server = server_scene.instantiate()
	$Servers/ServerSpawnPoint.add_child(server)

func _on_kill_box_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_stack_rack_servers_mounted(count: Variant) -> void:
	_set_server_count(server_quota - count)

func _set_server_count(count: int):
	server_count_label.text = server_count_text + str(count)
