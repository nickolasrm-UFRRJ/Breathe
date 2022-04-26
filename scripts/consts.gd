extends Node

## A Vector2 containing the screen resolution
const SCREEN_SIZE = Vector2(576, 324)
## The number of pixels of each placeable block
const TILE_SIZE = SCREEN_SIZE.x / 18 # <- GCD / 2
## A Vector2 containing a placeable block size
const TILE_SIZE_VEC = Vector2(TILE_SIZE, TILE_SIZE)
## Folder containing enemies scenes
const ENEMIES_PATH = "res://nodes/enemy/enemies/"
## Shop time until next wave
const SHOP_TIME = 15
## Folder containing level jsons
const LEVELS_PATH = "res://levels/"
const USER_LEVELS_PATH = "user://"
## <name>: <path> dictionary of scenes
const SCENE_PATHS = {
	"game": "res://scenes/game/Game.tscn",
	"editor": "res://scenes/editor/Editor.tscn",
	"menu": "res://scenes/menu/Menu.tscn",
	"results": "res://scenes/results/Results.tscn"
}
