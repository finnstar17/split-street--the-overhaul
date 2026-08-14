extends Node3D

@onready var chart_data = TrackAutoload.load_chart(TrackAutoload.current_track)
@onready var bottomBars = $Roads/BottomRoad/Bars
@onready var topBars = $Roads/TopRoad/Bars
@onready var player = $AudioStreamPlayer
@onready var timer = $Timer
var bar_scene = preload("res://scenes/gameplay/bar_scene.tscn")

var old_bar_pos = 0
var bar_count = 1
var bars = []

var song_pos = 0

func _ready():
	if not chart_data:
		return
	
	for i in range(12):
		create_bar(bottomBars)
		create_bar(topBars)
		old_bar_pos = bottomBars.get_node(str(bar_count)).position.z
		bar_count += 1

	player.stream = load(chart_data["file"])
	timer.start()

func _process(_delta):
	get_delta()

func create_bar(bar : Node3D):
	var new_bar = bar_scene.instantiate()
	var note_data = chart_data["note_data"]
	new_bar.name = str(bar_count)
	new_bar.note_data = note_data[str(bar_count)]
	new_bar.global_position.z = old_bar_pos - ((60.0 / float(TrackAutoload.bpm)) * 4.0 * TrackAutoload.speed)
	
	if bar_count == 1:
		new_bar.global_position.z -= TrackAutoload.speed * 2

	bar.add_child(new_bar)
	bars.append(new_bar)

func get_delta():
	var base_pos = player.get_playback_position()
	var last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = base_pos + last_mix - latency
	song_pos = max(song_pos, time)
	TrackAutoload.global_pos = song_pos


func _on_timer_timeout() -> void:
	player.play()
	print("playing")
