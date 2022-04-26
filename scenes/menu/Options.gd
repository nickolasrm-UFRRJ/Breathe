extends VBoxContainer


func _ready():
	$Middle/Checkboxes/MusicCheck.pressed = Settings.music_enabled
	$Middle/Checkboxes/SFXCheck.pressed = Settings.sfx_enabled

func _on_MusicCheck_toggled(button_pressed: bool):
	Settings.music_enabled = button_pressed

func _on_SFXCheck_toggled(button_pressed: bool):
	Settings.sfx_enabled = button_pressed
