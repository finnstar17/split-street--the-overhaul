extends Node3D

var input_table = {}
var note_table = {}
var press_time = 0
var end_time = 0

func check_notes():
	for note_index in input_table:
		var real_time = input_table[note_index]
		if (press_time >= real_time - 0.1) and (press_time <= real_time + 0.1):
			var note = note_table[note_index]
			if note:
				note.collect()
				print(real_time - press_time)
