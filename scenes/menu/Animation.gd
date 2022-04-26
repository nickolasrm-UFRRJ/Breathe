extends Node

onready var anim_dfa = $AnimationTree.get('parameters/playback')

# Transitions
func _on_Options_pressed():
	anim_dfa.travel('MoveMainToOptions')

func _on_OptionsReturn_pressed():
	anim_dfa.travel('MoveOptionsToMain')

func _on_Play_pressed():
	anim_dfa.travel('MoveMainToLevels')

func _on_LevelReturn_pressed():
	anim_dfa.travel('MoveLevelsToMain')

func _on_Credits_pressed():
	anim_dfa.travel('MoveMainToCredits')

func _on_CreditsReturn_pressed():
	anim_dfa.travel('MoveCreditsToMain')
