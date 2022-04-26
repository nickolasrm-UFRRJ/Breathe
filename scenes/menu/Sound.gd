extends Node

func _ready():
	Settings.connect('music_toggled', self, '_on_music_toggled')
	Settings.connect('sfx_toggled', self, '_on_sfx_toggled')
	$SFX.volume_db = 0.0 if Settings.sfx_enabled else -INF
	$Music.volume_db = 0.0 if Settings.music_enabled else -INF

func _input(event: InputEvent):
	if event.is_action_released('ui_accept'):
		$SFX.play_sound('click')

func _on_music_toggled(enabled: bool):
	$Music.volume_db = 0 if enabled else -80

func _on_sfx_toggled(enabled: bool):
	$SFX.volume_db = 0 if enabled else -80
