extends AudioStreamPlayer

## Sound folder
export(String) var folder = 'res://assets/'

## Name of sound file with extension
export(Array, String) var sound_names = []
var sounds = {}

var random = RandomNumberGenerator.new()

## Select one random sound from the list
export var single_random = false

func _ready():
	random.randomize()
	
	var to_load
	if single_random:
		to_load = [sound_names[random.randi() % sound_names.size()]]
	else:
		to_load = sound_names
	
	for sound in to_load:
		load_sound(sound)
	
	if autoplay:
		play_random()

## Loads a sound into memory
func load_sound(filename: String):
	var splitted = filename.split('.')
	filename = splitted[0]
	var extension = splitted[1]
	sounds[filename] = load('%s%s.%s' % [folder, filename, extension])

## Plays a sound
func play_sound(filename_without_extension: String):
	stream = sounds[filename_without_extension]
	play()

## Plays a random sound from the list
func play_random():
	play_sound(sounds.keys()[random.randi() % sounds.size()])
