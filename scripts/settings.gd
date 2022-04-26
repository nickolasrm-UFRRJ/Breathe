extends Node

signal music_toggled(enabled)
signal sfx_toggled(enabled)

var music_enabled = true setget set_music_enabled
var sfx_enabled = true setget set_sfx_enabled

## Changes the music global variable state
func set_music_enabled(enabled: bool):
	music_enabled = enabled
	emit_signal('music_toggled', enabled)

## Changes the sfx global variable state
func set_sfx_enabled(enabled: bool):
	sfx_enabled = enabled
	emit_signal('sfx_toggled', enabled)
