extends LinkButton

export(String) var url


func _on_Credits_pressed():
	OS.shell_open(url)
