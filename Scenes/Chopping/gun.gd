class_name Gun
extends Node2D


@onready var muzzle = $Muzzle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	#rotation = get_global_mouse_position().angle_to_point(position)

func get_muzzle_pos() -> Vector2:
	return muzzle.global_position
