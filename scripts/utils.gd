extends Node

## Converts a global position to map coordinades
static func convert_to_map_coords(global_position: Vector2) -> Vector2:
	return (global_position / Consts.TILE_SIZE).floor() * Consts.TILE_SIZE

## Checks if an instantiated scene inherits from a scene
static func inherits_from_scene(instance: Node, scene: PackedScene) -> bool:
	return instance.get_filename() == scene.get_path()

## Checks if an instantiated scene inherits from one of the scenes
static func inherits_from_scenes(instance: Node, scenes: Array) -> bool:
	for scene in scenes:
		if inherits_from_scene(instance, scene):
			return true
	return false

## Lists all dir contents
## Returns a list containing [0] -> Files; [1] -> Directories
static func list_dir(path: String) -> Array:
	var files = []
	var directories = []
	var dir: Directory = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)
	
	var file = dir.get_next()
	while file != '':
		if dir.current_is_dir():
			directories.append(file)
		else:
			files.append(file)
		file = dir.get_next()
	
	return [files, directories]
	
func merge(a: Dictionary, b: Dictionary) -> Dictionary:
	var c = {}
	for key in a:
		c[key] = a[key]
	for key in b:
		c[key] = b[key]
	return c
