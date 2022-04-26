extends Camera2D

func shake():
	$Animation.play('Shake')

func _on_Spawner_enemy_died(coins):
	shake()
