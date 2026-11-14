extends Node2D

func _ready() -> void:
	$Rope2D.create_rope($RopeAnchor.global_position, 60)
	await $Rope2D.spool(60)

var gate := NoFasterThan.new()

func _process(delta: float) -> void:
	gate.try(
		delta,
		func():
			if Input.is_action_pressed("move_up"):
				print("shorten")
				$Rope2D.spool(100)
			if Input.is_action_pressed("move_down"):
				print("lengthen")
				await $Rope2D.spool(-10)
	)
