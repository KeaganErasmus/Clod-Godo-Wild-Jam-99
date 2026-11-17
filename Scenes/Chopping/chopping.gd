extends Node2D

var rng = RandomNumberGenerator.new()

@onready var gun: Gun = $Gun
@onready var spawn_timer = $SpawnTimer
@onready var p1 = $p1
@onready var p2 = $p2
@onready var tree_node = $TreeNodes

@onready var bullet_scene := load("res://Scenes/Chopping/bullet.tscn")
@onready var tree_scene := load("res://tree.tscn")

@onready var chop_ui : ChopUI = $ChoppingUI

var mouse_pos: Vector2

@export var tree_spawn_timer: float = 1

var trees_chopped: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tree_killed.connect(increase_tree_counter)
	Global._start_global_timer()

func _process(_delta: float) -> void:
	if trees_chopped >= Global.tree_quota:
		win_game()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var muzzle_pos : Vector2 = gun.get_muzzle_pos()
			var dir: Vector2 =   get_viewport().get_mouse_position() - muzzle_pos
			shoot(dir.normalized())

func shoot(target: Vector2) -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	add_child(bullet)

	bullet.position = gun.get_muzzle_pos()
	bullet.set_target(target)

func spawn_tree() -> void:
	var tree : Node2D = tree_scene.instantiate()

	var random_x = randf_range(p1.position.x, p2.position.x)
	var random_y = randf_range(p1.position.y, p2.position.y)

	get_node("TreeNodes").add_child(tree)
	tree.set_position(Vector2(random_x, random_y))

func _on_spawn_timer_timeout() -> void:
	spawn_tree()

func win_game() -> void:
	Global._stop_global_timer()
	chop_ui.set_flavour_text("ALL TREES BURNED>>>>YIPPPEEE")
	spawn_timer.stop()
	clear_trees()
	await get_tree().create_timer(2).timeout
	Global._next_scene()

func clear_trees() -> void:
	var trees = get_node("TreeNodes").get_children()
	for tree in trees:
		tree.clear()

func increase_tree_counter():
	trees_chopped += 1
	chop_ui.set_trees_chopped(trees_chopped)
