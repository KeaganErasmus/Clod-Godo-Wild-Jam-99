extends RigidBody2D

var line_start_pos: Vector2
var line_end_pos: Vector2

@export var move_force = 20000
var locked_y

@export var magnet_speed = 200
var magnet_min_y = 0
var magnet_max_y = 680

func _ready() -> void:
	locked_y = global_position.y
	line_start_pos = $AnchorMarker.position
	line_end_pos = $Chain/Magnet.position
	#print("line_start_pos: " + str(line_start_pos))
	#print("line_end_pos: " + str(line_end_pos))
	$Chain/ChainLine.add_point(line_start_pos)
	$Chain/ChainLine.add_point(line_end_pos)
			

func _process(delta: float) -> void:
	line_start_pos = $AnchorMarker.position
	line_end_pos = $Chain/Magnet.position
	
	#print("line_start_pos: " + str(line_start_pos))
	#print("line_end_pos: " + str(line_end_pos))
	
	$Chain/ChainLine.set_point_position(0, line_start_pos)
	$Chain/ChainLine.set_point_position(1, line_end_pos)	
	
	var y_input = Input.get_axis("move_up", "move_down")
	
	# stop magnet from going too low, but allow it to go back up
	if ($Chain/Magnet.position.y >= magnet_max_y and y_input > 0):
		y_input = 0 
	$Chain/Magnet.position.y += magnet_speed * y_input * delta
	
func _physics_process(delta: float) -> void:
	position.y = locked_y
	var x_input = Input.get_axis("move_left", "move_right")
	apply_impulse(Vector2(move_force * x_input, 0))	
	
