tool
extends Area2D

export(Color) var color setget set_color
export(int, 0, 100) var size = Consts.TILE_SIZE / 4 setget set_size
export(int, 0, 100) var speed = Consts.TILE_SIZE / 3
export(int, 0, 1000) var damage = 2

var target = null
var velocity = Vector2(0,0)

# Setters
func set_color(color_: Color):
	color = color_
	if has_node('Repr'):
		$Repr.polygon_color = color

func set_size(size_: int):
	size = size_
	if has_node('Repr') and has_node('Collision'):
		$Collision.shape.radius = size / 2
		$Repr.size = size

# Init
func _ready():
	if target != null:
		velocity = target.global_position - global_position
		velocity = velocity.normalized() * speed

# Game loop
func _physics_process(delta):
	global_position += velocity

# Signals
func _on_Timer_timeout():
	queue_free() # exitted screen

func _on_Bullet_area_entered(area: Area2D):
	if area.is_in_group('Enemy'):
		queue_free()
