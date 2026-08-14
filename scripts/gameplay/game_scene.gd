extends Node3D

@onready var track_scene = preload("res://scenes/gameplay/track_scene.tscn")

func _ready():
    await get_tree().create_timer(1).timeout

    var new_track = track_scene.instantiate()
    
    TrackAutoload.current_track = "res://songs/charts/meowsynth kawaii future bass was a mistake.json"
    add_child(new_track)

