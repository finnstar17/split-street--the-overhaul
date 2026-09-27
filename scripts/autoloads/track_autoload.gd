extends Node

var player : AudioStreamPlayer

var current_track = ""

var bpm = 0
var global_pos = 0
var time_start = 0
var scene_start = 0
var input_time = 0
var delay = 0

var inputs = []

var current_id = 9000000

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

func calc_pos(variable):
	var base_pos = player.get_playback_position()
	var last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = base_pos + last_mix - latency
	var pos = max(variable, time)
	return pos

func calc_pos_delta():
	global_pos = calc_pos(global_pos)

func calc_pos_input():
	input_time = calc_pos(input_time)

func reset_vars():
	current_track = ""

	bpm = 0
	global_pos = 0
	time_start = 0

	inputs = []