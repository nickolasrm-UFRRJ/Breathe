tool
extends HBoxContainer

const ScreenCamera = preload('res://nodes/screen_camera/ScreenCamera.gd')

## Node for ScreenCamera that will scroll the screen
export(NodePath) var screen_camera_path
onready var screen_camera: ScreenCamera = get_node(screen_camera_path)

export var toggled = false setget set_toggled

## Hides or show the fixed sidebar
func set_toggled(toggled_: bool):
	toggled = toggled_
	if has_node("ButtonsList"):
		$ButtonsList.visible = toggled

func _on_Toggle_pressed():
	toggled = not toggled 
	set_toggled(toggled)

func _on_Waves_pressed():
	screen_camera.move_view(-1)

func _on_Drawer_pressed():
	screen_camera.move_view(0)

func _on_Inventory_pressed():
	screen_camera.move_view(1)

func _on_Menu_pressed():
	get_tree().change_scene(Consts.SCENE_PATHS.get("menu"))
