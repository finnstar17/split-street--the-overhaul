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

var old_song_pos = TrackAutoload.global_pos

var delay = 0.0
var started = false

func _ready():
	TrackAutoload.player = player
	TrackAutoload.scene_start = Time.get_ticks_msec()

	if not chart_data:
		return
	
	for i in range(chart_data["note_data"].size()):
		add_bar()

	player.stream = load(chart_data["file"])
	timer.start()

func _process(delta):
	var move_add = 0

	if player.playing and started:
		started = false
		move_add = delay
		TrackAutoload.delay = delay
		print("Delay: " + str(delay))

	TrackAutoload.calc_pos_delta()
	
	var song_delta = TrackAutoload.global_pos - old_song_pos
	var real_delta = 0
	if song_delta > 0:
		real_delta = song_delta
	else:
		real_delta = delta
	var movement = real_delta * SettingsAutoload.speed
	
	bottomBars.position.z += movement - (move_add * SettingsAutoload.speed)
	topBars.position.z += movement - (move_add * SettingsAutoload.speed)

	old_song_pos = TrackAutoload.global_pos

func add_bar():
	create_bar(bottomBars)
	create_bar(topBars)
	old_bar_pos = bottomBars.get_node(str(bar_count)).position.z
	bar_count += 1

func create_bar(bar : Node3D):
	var note_data = chart_data["note_data"]
	var bar_data = note_data[str(bar_count)]
	if bar_data:
		var new_bar = bar_scene.instantiate()
		new_bar.name = str(bar_count)
		new_bar.song_offset = chart_data["song_offset"]
		new_bar.note_data = note_data[str(bar_count)]
		new_bar.position.z = old_bar_pos - ((60 / float(TrackAutoload.bpm)) * 4 * SettingsAutoload.speed)
	
		if bar_count == 1:
			new_bar.position.z += (SettingsAutoload.speed * -4) + ((60 / float(TrackAutoload.bpm)) * 4 * SettingsAutoload.speed) - (chart_data["note_offset"] * SettingsAutoload.speed)

		bar.add_child(new_bar)
		bars.append(new_bar)

func _on_timer_timeout() -> void:
	delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	player.play()
	started = true
	print("playing")
