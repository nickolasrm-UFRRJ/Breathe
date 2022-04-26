extends VBoxContainer

const Card = preload('res://scenes/menu/LevelCard.tscn')

onready var level_list = get_node("Padding/Scroll/Cards")

func get_dicts(paths: Array) -> Array:
	var levels = []
	
	for path in paths:
		var f = File.new()
		f.open(path, File.READ)
		levels.append(JSON.parse(f.get_as_text()).result)
		f.close()
	
	return levels

func _ready():
	var levels = []
	for folder in [Consts.LEVELS_PATH, Consts.USER_LEVELS_PATH]:
		var filenames = Utils.list_dir(folder)[0]
		var filepaths = []
		for filename_ in filenames:
			filepaths.append(folder + filename_)
		levels += get_dicts(filepaths)
	
	Globals.level_dict = {}
	
	for level in levels:
		var card = Card.instance()
		card.level_name = level["name"]
		card.difficulty = level["difficulty"]
		card.connect("level_pressed", self, "_on_level_pressed")
		level_list.add_child(card)
		Globals.level_dict[level["name"]] = level
	
func _on_level_pressed(level_name: String):
	Globals.selected_level = level_name
	get_tree().change_scene(Consts.SCENE_PATHS.get("game"))
