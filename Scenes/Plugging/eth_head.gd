class_name EthHead
extends Node2D

var clicked_in: bool = false
var can_be_clicked_in: bool = false
var is_active: bool = false

@export var speed: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if is_active and !clicked_in:
		position.x -= speed
		#rotate(15)

func set_active_state(state: bool) -> void:
	is_active = state

func click_in() -> bool:
	if can_be_clicked_in:
		clicked_in = true
		is_active = false
		return true
	return false

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("can be clicked in")
	can_be_clicked_in = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("cant be clicked in")
	can_be_clicked_in = false
