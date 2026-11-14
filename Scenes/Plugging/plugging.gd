extends Node2D

@export var move_speed: int = 5

var num_active_ports: int = 4
var used = []

var starting_positions = [
	Vector2(1213.0, 94.0),
	Vector2(1213.0, 273.0),
	Vector2(1213.0, 434.0),
	Vector2(1213.0, 606.0),
]

var heads: Array[Node]

@onready var top_ports = $PortsTop.get_children()
@onready var bot_ports = $PortsBot.get_children()

@onready var line1 = $Line/Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_active_ports()
	heads = $EthHeads.get_children()

	line1.clear_points()
	line1.add_point($EthHeads/EthHead4.position, 0)
	line1.add_point($EthHeads/EthHead.position, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("ui_select"):
		for head in heads:
			head.click_in()

	for head in heads:
		if head.position.x <= 0:
			reset_head_position(head)
	set_ative_head()
	draw_connections()

func set_active_ports():
	var active_ports: int = 0
	var index: int = 0

	for port in top_ports:
		index = randi_range(0, top_ports.size() - 1)

		if !used.has(index):
			used.append(index)
			top_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

	used.clear()
	active_ports = 0

	for port in bot_ports:
		index = randi_range(0, bot_ports.size() - 1)

		if !used.has(index):
			used.append(index)
			bot_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

func set_ative_head():
	if Input.is_action_just_pressed("num_1"):
		$EthHeads/EthHead.set_active_state(true)
	if Input.is_action_just_pressed("num_2"):
		$EthHeads/EthHead2.set_active_state(true)
	if Input.is_action_just_pressed("num_3"):
		$EthHeads/EthHead3.set_active_state(true)
	if Input.is_action_just_pressed("num_4"):
		$EthHeads/EthHead4.set_active_state(true)

func reset_head_position(head: EthHead):
	head.set_active_state(false)
	if head == $EthHeads/EthHead:
		head.position = starting_positions[0]
	if head == $EthHeads/EthHead2:
		head.position = starting_positions[1]
	if head == $EthHeads/EthHead3:
		head.position = starting_positions[2]
	if head == $EthHeads/EthHead4:
		head.position = starting_positions[3]

func draw_connections():
	var line_start_pos = $EthHeads/EthHead.global_position - $Line/Line2D.global_position
	var line_end_pos = $EthHeads/EthHead4.global_position - $Line/Line2D.global_position
	line1.set_point_position(0, line_start_pos)
	line1.set_point_position(1, line_end_pos)
