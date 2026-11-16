extends Node2D

@onready var axe = $Axe
@onready var gun: Gun = $Gun

var bullet_scene = load("res://Scenes/Chopping/bullet.tscn")

var mouse_pos: Vector2

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
	bullet.set_scale(Vector2(0.5, 0.5))
	bullet.set_target(target)
