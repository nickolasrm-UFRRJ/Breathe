extends HBoxContainer

func get_enemies_list() -> Array: 
	var enemies = []
	for file in Utils.list_dir(Consts.ENEMIES_PATH)[0]:
		enemies.append(file.split('.')[0])
	return enemies

func _ready():
	$Enemies.clear()
	for enemy in get_enemies_list():
		$Enemies.add_item(enemy)

func _on_Remove_pressed():
	queue_free()

func generate_representation() -> Dictionary:
	return {
		"type": "enemy",
		"enemy": $Enemies.text,
		"delay": $Delay.value
	}
