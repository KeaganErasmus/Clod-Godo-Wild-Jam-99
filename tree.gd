class_name cTree
extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	var ob := area.get_parent()
	if ob is Bullet:
		ob.destroy()
		die()

func die() -> void:
	Global.tree_killed.emit()
	queue_free()

func clear() -> void:
	queue_free()
