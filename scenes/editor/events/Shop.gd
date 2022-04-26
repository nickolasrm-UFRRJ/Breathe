tool
extends HBoxContainer

func _ready():
	$Label.text = "Shop delay for "+String(Consts.SHOP_TIME)+" seconds after previous"

func _on_Remove_pressed():
	queue_free()

func generate_representation() -> Dictionary:
	return {"type": "shop"}
