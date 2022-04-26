extends Control

const Enemy = preload('res://scenes/editor/events/Enemy.tscn')
const Shop = preload('res://scenes/editor/events/Shop.tscn')

onready var list = get_node("Container/Waves/Scrollable")

## Adds an enemy row to the list
func add_enemy():
	list.add_child(Enemy.instance())

## Adds a shop delay before
func add_shop():
	list.add_child(Shop.instance())

func _on_Button_pressed():
	add_enemy()
	
func _on_Shop_pressed():
	add_shop()

# External
func _can_generate() -> String:
	if list.get_child_count() < 1:
		return "You must add at least one enemy"
	return "OK"

func generate_events():
	var can = _can_generate()
	if can == "OK":
		var events = []
		for event in list.get_children():
			events.append(event.generate_representation())
		return {"events": events,
				"stats": {
					"lives": $Container/Stats/Lives.value,
					"coins": $Container/Stats/Coins.value
				}}
	else:
		return can;
