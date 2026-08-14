extends Node3D

var note_scene = preload("res://scenes/gameplay/note_scene.tscn")
var note_data = {}

func _ready():
    for note in note_data["notes"]:
        if global_rotation.z == 0 and note["plane"] == 1:
            create_note(note)
        elif global_rotation.z != 0 and note["plane"] == 2:
            create_note(note)

func create_note(note):
    var new_note = note_scene.instantiate()
    new_note.xpos = (note["line"] - 2.5) * 0.4
    new_note.zpos = note["pos"]
    add_child(new_note)