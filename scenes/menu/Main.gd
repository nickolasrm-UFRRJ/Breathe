extends Control



func _on_Editor_pressed():
	get_tree().change_scene(Consts.SCENE_PATHS.get("editor"))
