class_name Bullet
extends Node2D

var target_pos: Vector2 = Vector2.ZERO
var shot_speed : float = 500


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += target_pos * shot_speed * delta
	$Sprite2D.rotate(10 * delta)
	if position.x <= 0 or position.x >= get_window().size.x or position.y <= 0 or position.y >= get_window().size.y:
		destroy()

func set_target(target: Vector2):
	target_pos = target

func destroy() -> void:
	queue_free()
