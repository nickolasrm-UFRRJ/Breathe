tool
extends HBoxContainer


export var toggled = true setget set_toggled

## Defines if the drawer sidebar is collapsed or not
func set_toggled(toggled_):
	toggled = toggled_
	$ButtonsList.visible = toggled

func _on_Toggle_pressed():
	set_toggled(not toggled)
