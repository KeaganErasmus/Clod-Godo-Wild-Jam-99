class_name Gun
extends Node2D


@onready var muzzle = $Muzzle
@onready var particles = $MuzzleParticle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	particles.emitting = false

func get_muzzle_pos() -> Vector2:
	return muzzle.global_position

func emit_particles() -> void:
	particles.emitting = true
