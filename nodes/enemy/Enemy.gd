tool
extends PathFollow2D

const Explosion = preload('res://nodes/explosion/Explosion.tscn')

signal died(coins)
signal hit(damage)

var dead = false

## Number of coins the enemy drops when killed
export(int, 1, 1000) var coins = 10
## Number of pixels the enemy moves by second
export(int, 1, 1000) var speed = Consts.TILE_SIZE * 6
## Maximum cumulative number of hits the enemy can receive without dying
export(int, 1, 1000) var health = 100

## Color of the enemy
export(Color) var color = Color.white setget set_color
## Number of sides of the polygon shape
export(int, 3, 30) var num_sides = 3 setget set_num_sides
## Size in pixels of the enemy
export(int, 1, 500) var size = Consts.TILE_SIZE setget set_size

# Setters
## Defines the color of the enemy
func set_color(color_: Color):
	color = color_
	if has_node('Physics/Repr'):
		$Physics/Repr.color = color

## Defines the number of regular polygon sides
func set_num_sides(num_sides_: int):
	num_sides = num_sides_
	if has_node('Physics/Repr'):
		$Physics/Repr.num_sides = num_sides

## Defines the size in pixels of the polygon
func set_size(size_: int):
	size = size_
	if has_node('Physics/Repr') and has_node('Physics/Collision'):
		$Physics/Repr.size = size
		var extent_side = int(size_ * 0.75)
		$Physics/Collision.shape.extents = Vector2(extent_side, extent_side)

# Game loop
func _physics_process(delta):
	if not Engine.editor_hint:
		if not try_die():
			move(delta)

## Moves an enemy through a Path2D
func move(delta):
	offset += speed * delta

## Creates an explosion object in the same position as the enemy
func explode():
	var explosion = Explosion.instance()
	explosion.global_position = global_position
	explosion.color = color
	explosion.size = size / 3
	get_tree().get_root().add_child(explosion)

## Checks if an Enemy died and kills it if dead
func try_die():
	if health > 0:
		return false
	elif not dead:
		dead = true
		explode()
		emit_signal('died', coins)
		queue_free()
	return true

## Sets the enemy to the dead state
func die():
	health = 0

## Applies damage to the enemy
func hit(damage: int):
	$Animation.play('hurt')
	health -= damage
	emit_signal("hit", damage)

# Signals
func _on_Physics_area_entered(area: Area2D):
	if area.is_in_group('Bullet'):
		hit(area.damage)

func _on_Animation_animation_finished(_anim_name):
	$Animation.stop()
