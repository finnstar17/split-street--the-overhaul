extends Node3D

var note_scene = preload("res://scenes/gameplay/note_scene.tscn")
var note_data = {}
var old_song_pos = TrackAutoload.global_pos

func _ready():
    for note in note_data["notes"]:
        if global_rotation.z == 0 and note["plane"] == 1:
            var new_note = note_scene.instantiate()
            new_note.xpos = (note["line"] - 2.5) * 0.4
            new_note.zpos = note["pos"]
            add_child(new_note)
        elif global_rotation.z != 0 and note["plane"] == 2:
            var new_note = note_scene.instantiate()
            new_note.xpos = (note["line"] - 2.5) * 0.4
            new_note.zpos = note["pos"]
            add_child(new_note)

func _process(delta):
    var song_delta = TrackAutoload.global_pos - old_song_pos
    var real_delta = 0

    if song_delta > 0:
        real_delta = song_delta
    else:
        real_delta = delta
    
    global_position.z += real_delta * TrackAutoload.speed

    old_song_pos = TrackAutoload.global_pos
