extends Node

onready var spawner = get_node("World/Spawner")
onready var path = get_node("World/Path")
onready var map = get_node("World/Map")
onready var wallet = get_node("UI/Wallet")
onready var lives = get_node("UI/Lives")

func load_level():
	if Globals.selected_level != null:
		var level = Globals.level_dict[Globals.selected_level]
		spawner.sequence = level["events"]
		wallet.budget = level["stats"]["coins"]
		lives.lives = level["stats"]["lives"]
		path.set_path(level["path"])
		map.place_blocks(level["blocks"])
		Globals.won = true
		Globals.score = 0

func _ready():
	load_level()

func _on_Lives_game_over():
	Globals.won = false
	get_tree().change_scene(Consts.SCENE_PATHS.get("results"))

func _on_Spawner_enemy_died(coins):
	Globals.score += coins

func _on_Spawner_sequence_ended():
	if lives.lives > 0:
		Globals.won = true
	else:
		Globals.won = false
	get_tree().change_scene(Consts.SCENE_PATHS.get("results"))
