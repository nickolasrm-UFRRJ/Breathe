tool
extends Node2D

const RegularPolygon2D = preload('res://addons/regular_polygon2d_node/RegularPolygon2D.gd')

export(Color) var color setget set_color
export(float, 0, 1) var darken_factor = 0.4 setget set_darken_factor


func set_color(color_: Color):
	color = color_
	if has_node('Base') and has_node('Gun') and has_node('Circle'):
		var dark_color = Color(color.r * darken_factor,
							   color.g * darken_factor,
							   color.b * darken_factor)
		for node in [$Base, $Gun]:
			node.border_color = color
			node.polygon_color = dark_color
		$Circle.color = Color(dark_color.r, dark_color.g, dark_color.b, 0.4)
	update()

func set_darken_factor(darken_factor_: float):
	darken_factor = darken_factor_
	set_color(color)
	update()
