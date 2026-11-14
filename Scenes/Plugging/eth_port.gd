class_name EthPort
extends Node2D

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_state(state: bool):
	is_active = state
	if state:
		$".".show()
