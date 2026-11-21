extends Node2D

@export var move_speed: int = 5

var num_active_ports: int = 2
var used = []

var starting_positions = [
	Vector2(1213.0, 273.0),
	Vector2(1213.0, 349.0),
	Vector2(1213.0, 434.0),
	Vector2(1213.0, 508.0),
]

var heads: Array[Node]
var all_heads_clicked: bool = false
var amount_clicked: int = 0

@onready var top_row_ports = $PortsTop/TopRow.get_children()
@onready var bot_row_ports = $PortsTop/BotRow.get_children()

@onready var b_top_row_ports = $PortsBot/TopRow.get_children()
@onready var b_bot_row_ports = $PortsBot/BotRow.get_children()

@onready var line1 = $Line/Line2D
@onready var line2 = $Line/Line2D2

@onready var gigga_x = $GiggaX

var next_head_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_ports()
	reset_lines()
	heads = $EthHeads.get_children()
	Global._start_global_timer()
	gigga_x.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		for head in heads:
			if head.click_in():
				MusicPlayer._play_eth_click()
				amount_clicked += 1

	for head in heads:
		if head.position.x <= 0:
			reset_head_position(head)

	#set_active_head()
	#if Input.is_action_just_pressed("num_1"):
		#MusicPlayer._play_wrong_effec()
		#show_gigga_x()
		#await get_tree().create_timer(1).timeout
		#reset_heads()
		#reset_lines()
		#next_head_index = 0


	draw_connections()

	if all_heads_clicked_in():
		if check_itersection():
			MusicPlayer._play_wrong_effec()
			show_gigga_x()
			reset_heads()
			reset_lines()
			next_head_index = 0
		else:
			Global._stop_global_timer()
			await get_tree().create_timer(2).timeout
			Global._next_scene()


func set_ports() -> void:
	var active_ports: int = 0
	var index: int = 0

	for port in top_row_ports:
		index = randi_range(0, top_row_ports.size() - 1)
		if !used.has(index):
			used.append(index)
			top_row_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

	used.clear()
	active_ports = 0

	for port in bot_row_ports:
		index = randi_range(0, bot_row_ports.size() - 1)
		if !used.has(index):
			used.append(index)
			bot_row_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

	used.clear()
	active_ports = 0

	for port in b_top_row_ports:
		index = randi_range(0, b_top_row_ports.size() - 1)
		if !used.has(index):
			used.append(index)
			b_top_row_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

	used.clear()
	active_ports = 0

	for port in b_bot_row_ports:
		index = randi_range(0, b_bot_row_ports.size() - 1)
		if !used.has(index):
			used.append(index)
			b_bot_row_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break

func set_active_head():
	if Input.is_action_just_pressed("num_1"):
		$EthHeads/EthHead.set_active_state(true)
	if Input.is_action_just_pressed("num_2"):
		$EthHeads/EthHead2.set_active_state(true)
	if Input.is_action_just_pressed("num_3"):
		$EthHeads/EthHead3.set_active_state(true)
	if Input.is_action_just_pressed("num_4"):
		$EthHeads/EthHead4.set_active_state(true)

func set_next_active_head() -> void:
	if next_head_index >= heads.size():
		next_head_index = 0

	if !heads[next_head_index].get_clicked_in_state():
		heads[next_head_index].set_active_state(true)

	next_head_index += 1

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
	if $EthHeads/EthHead.get_clicked_in_state() and $EthHeads/EthHead4.get_clicked_in_state():
		var line_start_pos = $EthHeads/EthHead/OffsetPos.global_position - line1.global_position
		var line_end_pos = $EthHeads/EthHead4/OffsetPos.global_position - line1.global_position
		line1.set_point_position(0, line_start_pos)
		line1.set_point_position(1, line_end_pos)
		line1.show()
	if $EthHeads/EthHead2.get_clicked_in_state() and $EthHeads/EthHead3.get_clicked_in_state():
		var line_start_pos = $EthHeads/EthHead2/OffsetPos.global_position - line1.global_position
		var line_end_pos = $EthHeads/EthHead3/OffsetPos.global_position - line1.global_position
		line2.set_point_position(0, line_start_pos)
		line2.set_point_position(1, line_end_pos)
		line2.show()

func check_itersection() -> bool:
	var p1: Vector2 = $EthHeads/EthHead/OffsetPos.global_position - line1.global_position
	var p2: Vector2 = $EthHeads/EthHead4/OffsetPos.global_position - line1.global_position

	var p3: Vector2 = $EthHeads/EthHead2/OffsetPos.global_position - line1.global_position
	var p4: Vector2 = $EthHeads/EthHead3/OffsetPos.global_position - line1.global_position

	var intersect_point = Geometry2D.segment_intersects_segment(p1, p2, p3, p4)

	if intersect_point:
		return true

	return false

func all_heads_clicked_in() -> bool:
	var amount: int = 0

	for head in heads:
		if head.get_clicked_in_state():
			amount = amount + 1

	if amount >= 4:
		return true

	return false

func reset_heads() -> void:
	for head in heads:
		reset_head_position(head)
		head.clicked_in = false

func reset_lines() -> void:
	line1.clear_points()
	line1.add_point(Vector2(0, 0), 0)
	line1.add_point(Vector2(100, 0), 1)
	line1.hide()

	line2.clear_points()
	line2.add_point(Vector2(300, 0), 0)
	line2.add_point(Vector2(400, 0), 1)
	line2.hide()

func show_gigga_x() -> void:
	gigga_x.show()
	var tween = create_tween()
	tween.tween_property(gigga_x, "scale", Vector2(0, 0), 1)
	await get_tree().create_timer(1).timeout
	tween.kill()
	gigga_x.scale = Vector2(5.92,4.24)
	gigga_x.hide()

func _on_send_pressed() -> void:
	MusicPlayer._play_button_click()
	set_next_active_head()

func _on_click_pressed() -> void:
	MusicPlayer._play_button_click()
	for head in heads:
		if head.click_in():
			amount_clicked += 1
			MusicPlayer._play_eth_click()
