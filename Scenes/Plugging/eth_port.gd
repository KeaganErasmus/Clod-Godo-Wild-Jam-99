class_name EthPort
extends Node2D

var is_active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_active:
		$Sprite2D.show()
	else:
		$Sprite2D.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
