extends Area2D

signal water_hit

func _on_body_entered(body: Node2D) -> void:
	water_hit.emit()
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(1).timeout
	queue_free()
