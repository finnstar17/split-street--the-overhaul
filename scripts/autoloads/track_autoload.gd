extends Node

var player : AudioStreamPlayer

var current_track = ""

var bpm = 0
var global_pos = 0
var time_start = 0
var scene_start = 0
var input_time = 0
var real_input_time = 0
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

func calc_pos_delta():
	var base_pos = player.get_playback_position()
	var last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = base_pos + last_mix - latency
	global_pos = max(global_pos, time)

func calc_pos_input():
	var base_pos = player.get_playback_position()
	var last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = base_pos + last_mix - latency
	real_input_time = max(real_input_time, time)
	if real_input_time <= 0.1:
		input_time = (Time.get_ticks_msec() - scene_start - 4000) / 1000.0
	else:
		input_time = real_input_time

func reset_vars():
	current_track = ""

	bpm = 0
	global_pos = 0
	time_start = 0

	inputs = []