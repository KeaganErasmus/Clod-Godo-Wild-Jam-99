extends Node2D

var server_scene = load("res://Scenes/stacking/scenes/server.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var server = server_scene.instantiate()
	$Servers/ServerSpawnPoint.add_child(server)

func _on_kill_box_body_entered(body: Node2D) -> void:
	body.queue_free()
