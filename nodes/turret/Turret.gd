tool
extends Node2D

const Enemy = preload('res://nodes/enemy/Enemy.tscn')
const Bullet = preload('res://nodes/bullet/Bullet.tscn')

export(bool) var enabled = true
export(bool) var show_range = false setget set_show_range
export(int, 0, 1000) var damage = 2
export(int, 0, 100) var speed = Consts.TILE_SIZE / 3
export(float, EXP, 0.1, 20, 0.05) var fire_delay = 1.0 setget set_fire_delay
export(int, 20, 1000) var attack_range = Consts.TILE_SIZE * 4 setget set_attack_range
export(int) var price = 100

export var size = Consts.TILE_SIZE setget set_size
var targets = []
var target = null

signal turret_collided_with_turret

# Setters
func set_size(size_: int):
	size = size_
	if has_node(@"Repr/Gun") and has_node(@"Repr/Base"):
		$Repr/Base.size = size * 0.8125 # aproximately
		$Repr/Base.border_size = size * 0.185
		var collision_side = size / 2
		var pos = Vector2(collision_side, collision_side)
		$Repr.position = pos
		$Range.position = pos

func set_fire_delay(fire_delay_: float):
	fire_delay = fire_delay_
	if has_node('FireTimer'):
		$FireTimer.wait_time = fire_delay

func set_attack_range(attack_range_: int):
	attack_range = attack_range_
	if has_node(@'Range/Collision') and has_node(@'Repr/Circle'):
		$Range/Collision.shape = CircleShape2D.new()
		$Range/Collision.shape.radius = attack_range
		$Repr/Circle.radius = attack_range

func set_show_range(show_range_: bool):
	show_range = show_range_
	if has_node(@'Repr/Circle'):
		$Repr/Circle.visible = show_range

# Game loop
func _ready():
	set_size(size)

func update_target():
	if len(targets) > 0:
		target = targets[0]
		for target_ in targets:
			# gets the most dangerous
			if target_.get_enemy().offset > target.get_enemy().offset:
				target = target_

func spot():
	$Repr/Gun.look_at(target.global_position)

func _physics_process(delta):
	if enabled:
		update_target()
		if target != null:
			spot()

# Signals
func _on_Range_area_entered(area: Node2D):
	if area.is_in_group('Enemy'):
		targets.append(area)

func _on_Range_area_exited(area: Node2D):
	if area.is_in_group('Enemy'):
		targets.erase(area)
		if target == area:
			target = null

func _on_Cell_area_entered(area: Area2D):
	if area.is_in_group('Turret'):
		emit_signal('TurretCollided')

func _on_FireTimer_timeout():
	if target != null:
		var bullet = Bullet.instance()
		bullet.color = $Repr.color
		bullet.target = target
		bullet.speed = speed
		bullet.damage = damage
		bullet.global_position = $Repr/Gun.global_position
		get_tree().get_root().add_child(bullet)
