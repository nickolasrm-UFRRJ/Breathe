tool
extends Node2D

const RegularPolygon2D = preload('res://addons/regular_polygon2d_node/RegularPolygon2D.gd')

export var color: Color setget set_color
export(float, 0, 1) var darken_factor = 0.4 setget set_darken_factor
export(int, 3, 30) var num_sides = 3 setget set_num_sides
export(int, 1, 500) var size = 64 setget set_size


func set_color(color_: Color):
	color = color_
	if has_node('Body'):
		var dark_color = Color(color.r * darken_factor,
							   color.g * darken_factor,
							   color.b * darken_factor)
		$Body.border_color = color
		$Body.polygon_color = dark_color
	update()

func set_darken_factor(darken_factor_: float):
	darken_factor = darken_factor_
	update()

func set_num_sides(num_sides_: int):
	num_sides = num_sides_
	if has_node('Body'):
		$Body.num_sides = num_sides
	update()

func set_size(size_: int):
	size = size_
	if has_node('Body'):
		$Body.size = size
		$Body.border_size = size / 2
	update()
