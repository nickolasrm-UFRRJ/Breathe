extends Control


## Generates the level if everything is ok
## Returns a Dictionary containing
## "errored" -> boolean; "message" -> Error message
## Or
## "errored" -> boolean; "message" -> Dictionary
func generate_level() -> Dictionary:
	var map = $Map.generate_map()
	var events = $Events.generate_events()
	
	if map is String:
		return {"errored": true, "message": map}
	if events is String:
		return {"errored": true, "message": events}
	
	return {"errored": false, "message": Utils.merge(map, events)}

func _on_Save_pressed():
	var level = generate_level()
	if level["errored"]:
		$Fixed/SavePopup.hide()
		$Fixed/SaveErrorPopup.show()
		$Fixed/SaveErrorPopup/ErrorMessage.text = level["message"]
	else:
		$Fixed/SaveErrorPopup.hide()
		$Fixed/SavePopup.show()

func _on_SavePopup_confirmed():
	var level = Utils.merge(
			generate_level()["message"], 
			{
			"name": $Fixed/SavePopup/Container/LevelName.text,
			"difficulty": $Fixed/SavePopup/Container/Difficulty.value
			}
		)
	var file = File.new()
	file.open(Consts.USER_LEVELS_PATH+level.get("name"), File.WRITE)
	file.store_line(JSON.print(level))
	file.close()
