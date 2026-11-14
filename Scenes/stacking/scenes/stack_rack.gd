extends Node2D

@onready var area := $ServerArea
var bodies
var body_count: int

signal servers_mounted(count)

func _on_server_area_body_entered(body: Node2D) -> void:
	bodies = area.get_overlapping_bodies()
	body_count = bodies.size()
	servers_mounted.emit(body_count)

func _on_server_area_body_exited(body: Node2D) -> void:
	bodies = area.get_overlapping_bodies()
	body_count = bodies.size()
	servers_mounted.emit(body_count)
