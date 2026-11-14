extends Node2D

var num_active_ports: int = 4
var used = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_active_ports()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_active_ports():
	var active_ports: int = 0
	var index: int = 0

	var top_ports = $PortsTop.get_children()
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

	var bot_ports = $PortsBot.get_children()
	for port in bot_ports:
		index = randi_range(0, bot_ports.size() - 1)

		if !used.has(index):
			used.append(index)
			bot_ports[index].set_state(true)
			active_ports += 1

		if active_ports >= num_active_ports:
			break
