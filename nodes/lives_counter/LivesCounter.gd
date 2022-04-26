tool
extends HBoxContainer

const Heart = preload('res://nodes/lives_counter/Heart.tscn')

signal game_over

export(int, 1, 9) var lives = 3 setget set_lives

func clear_hearts():
	for n in get_children():
		n.queue_free()

func set_lives(lives_: int):
	lives = lives_
	clear_hearts()
	for i in range(lives):
		var heart = Heart.instance()
		heart.name = 'Heart'+String(i)
		add_child(heart)

func _ready():
	set_lives(lives)

func die():
	if lives > 0:
		var hearts = get_children()
		var heart = hearts[len(hearts)-1]
		heart.explode()
		heart.queue_free()
		lives -= 1
	if lives == 0:
		emit_signal('game_over')

func _on_Path_enemy_reached():
	die()
