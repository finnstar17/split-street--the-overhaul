extends Node3D

var note_effect = preload("res://scenes/effects/note_effect.tscn")

var input_table = {}
var note_table = {}
var press_time = 0
var end_time = 0

var lowest_num = INF
var nearest_node : Node3D = null
var nearest_index = null

var margin = 0.3
var check_instant_margin = 0.5

func check_notes(s_margin, count_early):
	var hit_delay = 0.0
	lowest_num = INF
	nearest_node = null
	for note_index in input_table:
		var real_time = input_table[note_index] + SettingsAutoload.offset
		if (press_time <= real_time + s_margin) and (press_time >= real_time - (s_margin * count_early)):
			if real_time < lowest_num:
				lowest_num = real_time
				nearest_node = note_table[note_index]
				nearest_index = note_index
				hit_delay = real_time - press_time

	if nearest_node:
		nearest_node.collect()
		note_func()

		input_table.erase(nearest_index)
		note_table.erase(nearest_index)

		print(hit_delay)

func check_instant():
	check_notes(check_instant_margin, 0)

func note_func():
	var effect_instance : Node3D = note_effect.instantiate()
	add_child(effect_instance)
