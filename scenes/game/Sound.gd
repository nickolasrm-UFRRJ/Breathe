extends Node

var sfx = false
var music = false
var shop = false

func set_player(node: Node, variable: bool) -> bool:
	if variable:
		node.volume_db = 0.0
	else:
		node.volume_db = -INF
	return variable

func set_sfx(sfx_: bool):
	sfx = set_player($SFX, sfx_)

func set_music(music_: bool):
	music = set_player($Music, music_)

func set_shop(shop_: bool):
	shop = set_player($Shop, shop_)

func _ready():
	set_sfx(Settings.sfx_enabled)
	set_music(Settings.music_enabled)
	set_shop(Settings.music_enabled)

func _on_Spawner_enemy_died(coins):
	$SFX.play_sound('explosion')

func _on_Spawner_shop_started():
	if Settings.music_enabled:
		set_music(false)
		set_shop(true)
		$Shop.seek(0)

func _on_Spawner_shop_ended():
	if Settings.music_enabled:
		set_music(true)
		set_shop(false)
		$Music.seek(0)

func _on_Spawner_enemy_hit():
	$SFX.play_sound('hit')
