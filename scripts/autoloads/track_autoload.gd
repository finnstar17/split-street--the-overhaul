extends Node

var current_track = ""

var speed = 8
var bpm = 0
var global_pos = 0

# chart loader
func load_chart(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var json_string = file.get_as_text()

		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			bpm = json.data["bpm"]
			return json.data