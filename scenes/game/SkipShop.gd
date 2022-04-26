extends Button

export(NodePath) var spawner_path
onready var spawner = get_node(spawner_path)

func _on_Spawner_shop_started():
	disabled = false

func _on_Spawner_shop_ended():
	disabled = true

func _on_SkipShop_pressed():
	spawner.skip_shop()
	disabled = true
