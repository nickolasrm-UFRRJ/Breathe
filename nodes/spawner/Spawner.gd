tool
extends Node

const Path = preload('res://nodes/path/Path.tscn')

signal enemy_died(coins)
signal enemy_hit
signal shop_started
signal shop_ended
signal sequence_ended

export var start_delay = 10
export(NodePath) var path_node
onready var path: Path2D = get_node(path_node)
var enemy_count = 0

export(Array) var sequence = [] setget set_sequence

var is_shop = false setget set_shop


func start_shop():
	if enemy_count == 0:
		$Timer.start(Consts.SHOP_TIME)
		set_shop(true)

func set_shop(is_shop_: bool):
	if is_shop_ != is_shop:
		is_shop = is_shop_
		if is_shop:
			start_shop()
			emit_signal("shop_started")
		else:
			emit_signal("shop_ended")

func set_sequence(sequence_: Array):
	sequence_ = sequence_.duplicate()
	sequence_.push_front({"type": "shop"})
	sequence = sequence_

func _on_Timer_timeout():
	if len(sequence) > 0:
		var next = sequence.pop_front() as Dictionary
		if next.get('type') == 'enemy':
			set_shop(false)
			var node = load(Consts.ENEMIES_PATH+next.get('enemy')+'.tscn').instance()
			node.connect('died', self, '_on_Enemy_died')
			node.connect('hit', self,  '_on_Enemy_hit')
			path.add_child(node)
			enemy_count += 1
			var delay = next.get('delay')
			$Timer.start(delay)
		elif next.get('type') == 'shop':
			# wait until no enemies
			if enemy_count > 0:
				sequence.push_front(next)
				$Timer.start(1)
			else:
				set_shop(true)

func _on_Enemy_died(coins: int):
	enemy_count -= 1
	emit_signal('enemy_died', coins)
	if enemy_count == 0 and len(sequence) == 0:
		emit_signal("sequence_ended")

func _on_Enemy_hit(damage: int):
	emit_signal('enemy_hit')

func skip_shop():
	$Timer.start(0.1)
	set_shop(false)
