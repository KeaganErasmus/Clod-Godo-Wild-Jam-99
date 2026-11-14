class_name EthPort
extends Node2D

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$Area2D/CollisionShape2D.disabled = true

func set_state(state: bool):
	is_active = state
	if state:
		show()
		$Area2D/CollisionShape2D.disabled = false
