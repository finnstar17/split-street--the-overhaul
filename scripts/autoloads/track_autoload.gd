extends Node

var current_track = ""

var bpm = 0
var global_pos = 0
var time_start = 0

var inputs = []

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

func reset_vars():
	current_track = ""

	bpm = 0
	global_pos = 0
	time_start = 0

	inputs = []