extends Control


func _on_Click_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	get_tree().change_scene(Consts.SCENE_PATHS['menu'])
