extends Node2D

@export var move_speed: int = 5

var num_active_ports: int = 4
var used = []

var active_head: EthHead = null

var starting_positions = [
	Vector2(1213.0, 94.0),
	Vector2(1213.0, 273.0),
	Vector2(1213.0, 434.0),
	Vector2(1213.0, 606.0),
]

var heads: Array[Node]

@onready var top_ports = $PortsTop.get_children()
@onready var bot_ports = $PortsBot.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_active_ports()
	#reset_all_head_positions()
	heads = $EthHeads.get_children()

	print(top_ports[0].position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#var y_input = Input.get_axis("move_down", "move_up")
	#var x_input = Input.get_axis("move_left", "move_right")
	if active_head:
		pass
		#match y_input:
			#1.0:
				#active_head.move_head(Types.Direction.UP, move_speed)
			#-1.0:
				#active_head.move_head(Types.Direction.DOWN, move_speed)
		#match x_input:
			#1.0:
				#active_head.move_head(Types.Direction.RIGHT, move_speed)
			#-1.0:
				#active_head.move_head(Types.Direction.LEFT, move_speed)

	if Input.is_action_just_pressed("ui_select"):
		for head in heads:
			head.click_in()
		#if active_head.click_in():
			#active_head = null

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
		active_head = $EthHeads/EthHead
	if Input.is_action_just_pressed("num_2"):
		active_head = $EthHeads/EthHead2
	if Input.is_action_just_pressed("num_3"):
		active_head = $EthHeads/EthHead3
	if Input.is_action_just_pressed("num_4"):
		active_head = $EthHeads/EthHead4

	if active_head:
		active_head.set_active_state(true)

func reset_head_position(head: EthHead):
	if head == active_head:
		active_head.set_active_state(false)
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
	draw_line(top_ports[0].position, bot_ports[0].position, Color.BLACK)
