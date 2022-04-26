tool
extends CenterContainer

signal level_pressed(level_name)

export var level_name = "Name" setget set_level_name
export(int, 0, 2) var difficulty = 0 setget set_difficulty
const difficulties = {0: Color.green, 1: Color.yellow, 2: Color.red}

func set_level_name(level_name_: String):
	level_name = level_name_
	if has_node("Panel/Label"):
		$Panel/Label.text = level_name

func set_difficulty(difficulty_: int):
	difficulty = difficulty_
	if has_node("Panel"):
		$Panel.self_modulate = difficulties[difficulty]

func _on_Panel_gui_input(event: InputEvent):
	if event.is_action("ui_accept"):
		emit_signal("level_pressed", level_name)
