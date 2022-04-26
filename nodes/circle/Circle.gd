tool
extends Node2D

export(Color) var color setget set_color

export(bool) var centered = false setget set_centered
var offset: Vector2 = Vector2(0,0)

export var radius = Consts.TILE_SIZE / 2 setget set_radius

func set_color(color_):
	color = color_
	update()

func set_centered(centered_):
	centered = centered_
	if not centered:
		offset = Vector2(radius, radius)
	else:
		offset = Vector2.ZERO
	update()

func set_radius(radius_):
	radius = radius_
	set_centered(centered)
	update()

func _draw():
	draw_circle(position+offset, radius, color)
