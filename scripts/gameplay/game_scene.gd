extends Node3D

@onready var track_scene = preload("res://scenes/gameplay/track_scene.tscn")

func _ready():
	await get_tree().create_timer(0.5).timeout

	var new_track = track_scene.instantiate()
	
	#TrackAutoload.current_track = "res://songs/charts/meowsynth kawaii future bass was a mistake.json"
	#TrackAutoload.current_track = "res://songs/charts/Trick Room.json"
	TrackAutoload.current_track = "res://songs/charts/Rainshower.json"
	#TrackAutoload.current_track = "res://songs/charts/nano love.json"
	add_child(new_track)
	new_track.get_tree().paused = true

	await get_tree().create_timer(0.5).timeout

	new_track.get_tree().paused = false
