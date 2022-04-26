extends Control

const Explosion = preload('res://nodes/explosion/Explosion.tscn')

func explode():
	var explosion = Explosion.instance()
	explosion.color = $Repr.polygon_color
	explosion.size = 2
	explosion.global_position = $Repr.global_position + Vector2($Repr.size / 2,
																$Repr.size / 2)
	get_tree().get_root().add_child(explosion)
