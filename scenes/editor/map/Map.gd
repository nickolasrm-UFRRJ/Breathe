tool
extends Control

const Block = preload('res://nodes/ground/Block.tscn')

const Ground = preload('res://nodes/ground/Ground.tscn')
const Start = preload('res://nodes/ground/Start.tscn')
const End = preload('res://nodes/ground/End.tscn')

const path_scenes = [Start, End, Ground]
const special_paths = [Start, End]

const grid_size = Consts.SCREEN_SIZE / Consts.TILE_SIZE_VEC

var selected_block = null # eraser
var drawing = false

var unique_scenes = {Start: null, End: null} # set
var unique_blocks = {}
const map = {}

## Checks if the selected_block is the eraser
func _is_eraser() -> bool:
	return selected_block == null

## Checks if the selected_block is the same type of the already placed block
func _is_same_block(map_coords: Vector2) -> bool:
	return (not _is_eraser() and
		Utils.inherits_from_scene(map.get(map_coords), selected_block))

## Removes a block from the drawer grid
func _remove_block(map_coords: Vector2):
	var block = map.get(map_coords)
	
	if unique_blocks.has(block):
		unique_scenes[unique_blocks.get(block)] = null
		unique_blocks.erase(block)
	
	map.erase(map_coords)
	block.queue_free()

## Places a block into the drawer grid
func _place_block(map_coords: Vector2):
	var block = selected_block.instance()
	
	if unique_scenes.has(selected_block):
		unique_scenes[selected_block] = block
		unique_blocks[block] = selected_block
	
	block.global_position = map_coords
	map[map_coords] = block
	$Canvas.add_child(block)

## Moves a block from one position to another
func _move_block(block: Node2D, map_coords: Vector2):
	var old_coords = block.global_position
	block.global_position = map_coords
	map.erase(old_coords)
	map[map_coords] = block

## Adds a block into the drawer grid
func _add_block(map_coords: Vector2):
	if unique_scenes.has(selected_block):
		if unique_scenes.get(selected_block) == null:
			_place_block(map_coords)
		else:
			_move_block(unique_scenes.get(selected_block), map_coords)
	else:
		_place_block(map_coords)

## Verifies whether placing a block in a certain position creates a path branch
func _is_branch(map_coords: Vector2) -> bool:
	var neighbors = []
	for i in range(-1, 2):
		for j in range(-1, 2):
			var pos = map_coords + Vector2(i*Consts.TILE_SIZE, j*Consts.TILE_SIZE)
			if map.has(pos) and Utils.inherits_from_scenes(map.get(pos), path_scenes):
				neighbors.append(map.get(pos))
	
	if len(neighbors) > 2:
		return true
	
	for neighbor in neighbors:
		var neighbor_pos = neighbor.global_position
		var diff = neighbor_pos - map_coords
		if diff.x == 0 or diff.y == 0:
			var pos = neighbor_pos + diff
			if map.has(pos) and Utils.inherits_from_scenes(map.get(pos), path_scenes):
				for diff_sign in [-1, 1]:
					pos = neighbor_pos + diff_sign*Vector2(diff.y, diff.x)
					if map.has(pos) and Utils.inherits_from_scenes(map.get(pos), path_scenes):
						return true
	
	return false

## Checks whether placing a path in a position creates a diagonal
func _is_diagonal(map_coords: Vector2):
	for x in [-1, 1]:
		for y in [-1, 1]:
			var offset = Vector2(x,y)*Consts.TILE_SIZE_VEC
			var pos = map_coords + offset
			if (map.has(pos) and
				Utils.inherits_from_scenes(map.get(pos), path_scenes)):
				return true
	return false

## Checks whether placing a path in a position creates a curve
func _is_curve(map_coords: Vector2):
	for axis in [0, 1]:
		for direction in [-1, 1]:
			var offset = Vector2.ZERO
			offset[axis] = Consts.TILE_SIZE*direction
			var pos = map_coords + offset
			if (map.has(pos) and
				Utils.inherits_from_scenes(map.get(pos), path_scenes)):
				return true
	return false

## Checks if any special neighbors (e.g. entry or exit) are neighbors
func _is_neighbor_of_specials(map_coords: Vector2):
	for axis in [0, 1]:
		for direction in [-1, 1]:
			var offset = Vector2.ZERO
			offset[axis] = Consts.TILE_SIZE*direction
			var pos = map_coords + offset
			if (map.has(pos) and
				Utils.inherits_from_scenes(map.get(pos), special_paths)):
				return true
	return false

## Checks if there are more than one neighbour path
func _has_at_most_a_neighbor(map_coords: Vector2):
	var count = 0
	for axis in [0, 1]:
		for direction in [-1, 1]:
			var offset = Vector2.ZERO
			offset[axis] = Consts.TILE_SIZE*direction
			var pos = map_coords + offset
			if (map.has(pos) and
				Utils.inherits_from_scene(map.get(pos), Ground)):
				count+=1
	return count <= 1

## Checks if a block can be placed in a specified position
func _can_place(map_coords: Vector2):
	if selected_block == Ground:
		return (not _is_branch(map_coords) and
			(not _is_diagonal(map_coords) or _is_curve(map_coords)) and
			not _is_neighbor_of_specials(map_coords))
	elif unique_scenes.has(selected_block):
		return (map.has(map_coords) and
			Utils.inherits_from_scene(map.get(map_coords), Ground) and
			_has_at_most_a_neighbor(map_coords))
	elif selected_block == Block:
		return not map.has(map_coords)
	else:
		return true

func _process(delta):
	if drawing:
		var mouse_pos = Utils.convert_to_map_coords(get_global_mouse_position())
		
		if _can_place(mouse_pos):
			if map.has(mouse_pos):
				if not _is_same_block(mouse_pos):
					_remove_block(mouse_pos)
					if not _is_eraser():
						_add_block(mouse_pos)
			elif not _is_eraser():
				_add_block(mouse_pos)

func _on_Canvas_gui_input(event: InputEvent):
	if event.is_action("ui_accept"):
		drawing = event.is_pressed()

func _on_Path_button_up():
	selected_block = Ground

func _on_Eraser_button_up():
	selected_block = null

func _on_Block_button_up():
	selected_block = Block

func _on_Start_button_up():
	selected_block = Start

func _on_End_button_up():
	selected_block = End

# External

# Checks there are enough criterias to create a new level map
func _can_generate() -> String:
	if unique_scenes.get(Start) == null:
		return "Start point not defined yet"
	if unique_scenes.get(End) == null:
		return "End point not defined yet"
	if len(map) < 3:
		return "At least one path is required"
	return "OK"

## Generates the json like dictionary that describes the level
func generate_map():
	var can_gen = _can_generate()
	if can_gen == "OK":
		var start = unique_scenes.get(Start)
		var start_pos = start.global_position
		
		var blocks = []
		var path = [[start_pos.x, start_pos.y]]
		
		var current = start
		var last = null
		var found = true
		
		while found:
			found = false
			var current_pos = current.global_position
			
			for axis in [0, 1]:
				for direction in [-1, 1]:
					if not found:
						var offset = Vector2.ZERO
						offset[axis] = Consts.TILE_SIZE*direction
						var new_pos = current_pos + offset
						if (map.has(new_pos)):
							var next = map.get(new_pos)
							if (Utils.inherits_from_scenes(next, path_scenes) and 
								next != last):
								path.append([new_pos.x, new_pos.y])
								last = current
								current = next
								found = true
		
		for pos in map:
			if Utils.inherits_from_scene(map.get(pos), Block):
				blocks.append([pos.x, pos.y])
		
		return {"path": path, "blocks": blocks}
	else:
		return can_gen
