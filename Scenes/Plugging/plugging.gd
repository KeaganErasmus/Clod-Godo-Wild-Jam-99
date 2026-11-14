extends Node2D

@export var eth_port_scene = preload("res://Scenes/Plugging/eth_port.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		spaw_ports()

func spaw_ports() -> void:
	var eth_port = eth_port_scene.instantiate()
	eth_port.position.x = 500
	add_child(eth_port)
