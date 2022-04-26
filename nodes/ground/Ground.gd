tool
extends Node2D

export(Color) var color = Color.white setget set_color

const max_size = Consts.TILE_SIZE
export var size = max_size setget set_size

func set_color(color_: Color):
	color = color_
	if has_node("Repr"):
		$Repr.color = Color(color.r, color.g, color.b, 0.2)

func set_size(size_: float):
	size = min(size_, max_size)
	if has_node("Repr"):
		$Repr.rect_size = Vector2(size, size)
		var padding = (max_size - size) / 2
		$Repr.rect_position = Vector2(padding, padding)
