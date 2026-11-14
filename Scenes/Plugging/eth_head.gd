extends Node2D

var clicked_in: bool = false
var can_be_clicked_in: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func _process(delta: float) -> void:
	#rotation = 0.0

func move_head(dir: Types.Direction, speed: int) -> void:
	if clicked_in:
		return

	match dir:
		Types.Direction.LEFT:
			rotate(15)
			position.x -= speed
		Types.Direction.RIGHT:
			rotate(15)
			position.x += speed
		Types.Direction.UP:
			rotate(15)
			position.y -= speed
		Types.Direction.DOWN:
			rotate(15)
			position.y += speed

func click_in() -> void:
	if can_be_clicked_in:
		clicked_in = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	can_be_clicked_in = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	can_be_clicked_in = false
