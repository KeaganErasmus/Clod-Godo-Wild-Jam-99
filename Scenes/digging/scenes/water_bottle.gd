extends Area2D

signal water_hit

func _on_body_entered(body: Node2D) -> void:
	water_hit.emit()
	queue_free()
