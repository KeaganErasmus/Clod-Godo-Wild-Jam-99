extends CharacterBody2D

var magnetized := false
var attracted_bodies = []
@export var magnet_force: int = 10000

func _process(delta: float) -> void:
	magnetized = true if Input.is_action_pressed("magnetize") else false
	$MagnetArea/MagnetismCircle.visible = magnetized


func _physics_process(delta: float) -> void:
	var bodies = $MagnetArea.get_overlapping_bodies()
	for server in bodies:
		if server.has_method("apply_central_force"):
			var diff : Vector2 = (global_position - server.global_position).normalized()
			if magnetized:
				server.apply_central_force(diff.normalized() * magnet_force)
