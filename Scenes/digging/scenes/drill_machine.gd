extends RigidBody2D

@onready var drill = $Drill
@onready var drill_home = $DrillHome
@onready var drill_charge_bar = $DrillChargeBar
@onready var wheel1 = $Wheel
@onready var wheel2 = $Wheel2
var line_start_pos: Vector2
var line_end_pos: Vector2

@export var move_force = 50
var drill_charge: float = 0
var drill_charge_max: float = 10
var drill_charge_rate: float = 10
var drill_move_scale: float = 3

var drilling = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drill_charge_bar.min_value = 0
	drill_charge_bar.max_value = drill_charge_max

	line_start_pos = $DrillHome.position
	line_end_pos = $Drill.position
	#print("line_start_pos: " + str(line_start_pos))
	#print("line_end_pos: " + str(line_end_pos))
	$DrillLine.add_point(line_start_pos)
	$DrillLine.add_point(line_end_pos)

func _process(delta: float) -> void:
	drill_charge_bar.value = drill_charge
	#drill.global_position.x = global_position.x

	line_start_pos = $DrillHome.position
	line_end_pos = $Drill.position

	line_start_pos.y -= 36
	line_end_pos.y -= 32

	$DrillLine.set_point_position(0, line_start_pos)
	$DrillLine.set_point_position(1, line_end_pos)

	if drilling and drill_charge < 1:
		$Drill._digging_particles(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if drilling and drill_charge < 0.05:
		drill_charge = 0
		drilling = false
		MusicPlayer.diggin_sound.set_playing(false)

	var x_input = Input.get_axis("move_left", "move_right")
	if not drilling:
		if !MusicPlayer.car_sound.is_playing():
			MusicPlayer._play_car_sound()

		apply_impulse(Vector2(move_force * x_input, 0))

	if not drilling and Input.is_action_pressed("magnetize"):
		if drill_charge < drill_charge_max:
			drill_charge += drill_charge_rate * delta
	elif drill_charge > 0:
		if drill_charge > drill_charge_max:
			drill_charge = drill_charge_max
		if not drilling:
			_shoot_drill()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if drilling:
		linear_velocity = Vector2(0,0)
		wheel1.linear_velocity = Vector2(0,0)
		wheel2.linear_velocity = Vector2(0,0)

func _shoot_drill():
	MusicPlayer._play_drill_shot()
	MusicPlayer._play_digging_sound()
	drilling = true
	$Drill._digging_particles(true)
	while drilling and drill_charge > 0.05:
		#print(drill_charge)
		$Drill._set_particle_velocity_max(drill_charge)
		drill.position.y += drill_charge * drill_move_scale

		drill_charge = lerp(drill_charge, float(0), 0.05)
		await get_tree().create_timer(0.01).timeout

	drill.global_position = drill_home.global_position
