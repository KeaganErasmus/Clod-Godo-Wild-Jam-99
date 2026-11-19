class_name cTree
extends Node2D

@onready var p_emitter = $MuzzleParticle

var active: bool = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	var ob := area.get_parent()
	if ob is Bullet and active:
		ob.destroy()
		die()

func die() -> void:
	Global.tree_killed.emit()
	p_emitter.emitting = true
	$Sprite2D.hide()
	active = false
	await get_tree().create_timer(1).timeout
	queue_free()

func clear() -> void:
	queue_free()
