tool
extends Camera2D

onready var tween = get_node('Tween')

func _tween_scroll(prop: String, destination):
	var origin = get(prop)
	tween.interpolate_property(
		self,
		prop,
		origin,
		destination,
		0.25,
		tween.TRANS_CUBIC,
		tween.EASE_OUT)

func move_view(hidx, vidx = 0):
	_tween_scroll('global_position', Consts.SCREEN_SIZE * Vector2(hidx, vidx))
	tween.start()
