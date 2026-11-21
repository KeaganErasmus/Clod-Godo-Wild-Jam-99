class_name cTree
extends Node2D

@onready var p_emitter = $MuzzleParticle

var active: bool = true

var left: bool = false

var move_speed: int = 400

func _ready() -> void:
	var rand = randi()
	if rand % 2 == 0:
		left = false
	else:
		left = true

func _process(delta: float) -> void:
	#wiggle(delta)
	if left:
		position.x -= move_speed * delta
	else:
		position.x += move_speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	var ob := area.get_parent()
	if ob is Bullet and active:
		ob.destroy()
		die()

func die() -> void:
	MusicPlayer._play_crack_effec()
	MusicPlayer._play_ah_sound()
	Global.tree_killed.emit()
	p_emitter.emitting = true
	$Sprite2D.hide()
	active = false
	await get_tree().create_timer(1).timeout
	queue_free()

func clear() -> void:
	queue_free()


func wiggle(delta: float) -> void:
	$Sprite2D.rotate(lerpf(0, 0.5, delta))
