tool
extends Node

const Block = preload('res://nodes/ground/Block.tscn')
const Ground = preload('res://nodes/ground/Ground.tscn')
const Start = preload('res://nodes/ground/Start.tscn')
const End = preload('res://nodes/ground/End.tscn')

var map = {}

## Converts a node global position to map coordinades
func convert_node_global_position_to_map_coords(
		node: Node2D,
		map_coords: bool = false) -> Vector2:
	var position = node.global_position
	if not map_coords:
		position = Utils.convert_to_map_coords(position)
	return position

## Checks if a position is occupied, and if not, places an object
## and moves it.
func place(node: Node2D, map_coords: bool = false) -> bool:
	if is_occupied(node, map_coords):
		return false
	else:
		var position = convert_node_global_position_to_map_coords(node,
																  map_coords)
		map[position] = node
		node.global_position = position
		add_child(node)
		return true

## Checks if a position is occupied
func is_occupied(node: Node2D, map_coords: bool = false) -> bool:
	return convert_node_global_position_to_map_coords(node, map_coords) in map

## Places barriers into maps
func place_blocks(blocks: Array):
	for pos in blocks:
		var block = Block.instance()
		block.global_position = Vector2(pos[0], pos[1])
		place(block, true)

## Places map paths into maps
func place_path(path: Array):
	var first = path.pop_front()
	var start = Start.instance()
	start.global_position = Vector2(first[0], first[1])
	place(start, true)
	
	var last = path.pop_back()
	var end = End.instance()
	end.global_position = Vector2(last[0], last[1])
	place(end, true)
	
	for pos in path:
		var ground = Ground.instance()
		ground.global_position = pos
		place(ground, true)
