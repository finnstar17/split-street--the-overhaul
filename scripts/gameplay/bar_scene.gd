extends Node3D

var note_scene = preload("res://scenes/gameplay/note_scene.tscn")
var note_data = {}
var inputs = TrackAutoload.inputs

func _ready():
    var note_index = 1
    for note in note_data["notes"]:
        var new_note : Node3D = null
        if global_rotation.z == 0 and note["plane"] == 1:
            new_note = create_note(note)
        elif global_rotation.z != 0 and note["plane"] == 2:
            new_note = create_note(note)

        for input in inputs:
            if note["line"] == input.get_meta("Line") and note["plane"] == input.get_meta("Plane"):
                input.input_table[note_index] = {new_note = note["pos"]}
                print("hellllyeah")

        note_index += 1


func create_note(note):
    var new_note = note_scene.instantiate()
    new_note.xpos = (note["line"] - 2.5) * 0.4
    new_note.zpos = note["pos"]
    add_child(new_note)
    return new_note