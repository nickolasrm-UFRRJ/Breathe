extends VBoxContainer


func _ready():
	if Globals.won:
		$Status/Status.text = "YOU WON!"
	else:
		$Status/Status.text = "YOU LOST!"
	$Status/Score.text = "Your score was "+String(Globals.score)
	$Music.volume_db = 0.0 if Settings.music_enabled else -INF

func _on_Back_pressed():
	get_tree().change_scene(Consts.SCENE_PATHS.get("menu"))
