tool
extends Node2D

export var color: Color setget set_color
export var size: int = 12 setget set_size

func _ready():
	$Particle.emitting = true
	$Timer.start()

func set_color(color_: Color):
	color = color_
	if has_node('Particle'):
		modulate = color

func set_size(size_: int):
	size = size_
	if has_node('Particle'):
		var new_scale = (1.0 / 12.0) * size
		$Particle.scale = Vector2(new_scale, new_scale)

func _on_Timer_timeout():
	if not Engine.editor_hint:
		queue_free()
