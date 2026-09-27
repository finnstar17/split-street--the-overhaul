extends Node3D

var note_scene = preload("res://scenes/gameplay/note_scene.tscn")
var song_offset = 0.0
var note_data = {}
var inputs = TrackAutoload.inputs

func _ready():
	var mili = 60 / float(TrackAutoload.bpm)
	for note in note_data["notes"]:
		var new_note : Node3D = null
		if get_parent().get_meta("Plane") == 1 and note["plane"] == 1:
			new_note = create_note(note)
		elif get_parent().get_meta("Plane") == 2 and note["plane"] == 2:
			new_note = create_note(note)

		for input in inputs:
			if note["line"] == input.get_meta("Line") and note["plane"] == input.get_meta("Plane") and new_note != null:
				TrackAutoload.current_id += 1
				var note_index = str(TrackAutoload.current_id)
				input.input_table[note_index] = (int(name) * 4 * mili) + (note["pos"] * mili * 0.5) - 1.333
				input.note_table[note_index] = new_note
				input.song_offset = song_offset
				new_note.real_time = input.input_table[note_index]


func create_note(note):
	var new_note = note_scene.instantiate()
	new_note.xpos = (note["line"] - 2.5) * 0.4
	new_note.zpos = note["pos"]
	if "length" in note:
		new_note.length = note["length"] * 2.5
	add_child(new_note)
	return new_note
