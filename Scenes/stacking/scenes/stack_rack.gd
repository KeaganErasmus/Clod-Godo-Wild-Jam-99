extends Node2D

@onready var area := $ServerArea

func _process(delta: float) -> void:
	var bodies = area.get_overlapping_bodies()
	#print(bodies.size());
