tool
extends Path2D

const Map = preload('res://nodes/map/Map.gd')
const Ground = preload('res://nodes/ground/Ground.tscn')

signal enemy_reached

export(NodePath) var map_path
onready var map: Map = get_node(map_path)

export var finish_line_size = Consts.TILE_SIZE setget set_finish_line_size

func set_finish_line_size(size_: int):
	finish_line_size = size_
	if has_node("FinishLine/Collision"):
		var side = size_ / 2
		$FinishLine/Collision.shape.extents = Vector2(side, side)

func update_map():
	var path_pos = []
	var last = Utils.convert_to_map_coords(curve.get_point_position(0))
	for idx in range(1, curve.get_point_count()):
		var current = Utils.convert_to_map_coords(curve.get_point_position(idx))
		var point_count = ((current - last) / Consts.TILE_SIZE_VEC).ceil()
		var sign_vec = point_count.sign()
		for x in range(0, point_count.x + sign_vec.x, sign_vec.x):
			for y in range(0, point_count.y + sign_vec.y, sign_vec.y):
				var pos = Vector2(x,y) * Consts.TILE_SIZE_VEC + last
				path_pos.append(pos)
		last = current
	$FinishLine.global_position = last + Consts.TILE_SIZE_VEC / 2
	map.place_path(path_pos)

func set_path(points_: Array):
	curve.clear_points()
	for point in points_:
		curve.add_point(Vector2(point[0], point[1]) + (Consts.TILE_SIZE_VEC / 2))
	update_map()

func _on_FinishLine_area_entered(area: Area2D):
	if area.is_in_group('Enemy'):
		area.get_enemy().die()
		emit_signal("enemy_reached")
