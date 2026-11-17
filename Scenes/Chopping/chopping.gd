extends Node2D

var rng = RandomNumberGenerator.new()

@onready var axe = $Axe
@onready var gun: Gun = $Gun
@onready var spawn_area = $Area2D/CollisionShape2D
@onready var spawn_timer = $SpawnTimer
@onready var p1 = $p1
@onready var p2 = $p2

var bullet_scene := load("res://Scenes/Chopping/bullet.tscn")
var tree_scene := load("res://tree.tscn")

var mouse_pos: Vector2

@export var tree_spawn_timer: float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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

	add_child(tree)
	tree.set_position(Vector2(random_x, random_y))

func _on_spawn_timer_timeout() -> void:
	spawn_tree()
