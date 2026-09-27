extends Node3D

@export var collected = false

var xpos = 0
var zpos = 0
var type = 1
var length = 0.0

var holding = true
var last_time = 0.0
var real_time = 0.0

var picker = null

func _ready():
	position.x = xpos
	position.z = -zpos * (60 / float(TrackAutoload.bpm)) * SettingsAutoload.speed * 0.5

	if length > 0:
		var nscale = 1.0 + (length * (60 / float(TrackAutoload.bpm)) * SettingsAutoload.speed * 0.5)
		$PlainNote.hide()
		$HoldNote.show()
		$HoldNote.scale.z = nscale
		$HoldNote.position.z = (-nscale * 0.4) + 0.2

func collect():
	if length > 0:
		collected = true
		last_time = TrackAutoload.global_pos
		var distance_from_picker = picker.global_position.z - global_position.z
		$HoldNote.scale.z += distance_from_picker * 2.5
		print(distance_from_picker)
		$HoldNote/HoldMesh.transparency = 0.25
	else:
		collected = true
		queue_free()

func _process(_delta):
	if collected:
		var current_time = TrackAutoload.global_pos
		if not holding:
			queue_free()
		else:
			var time_diff = current_time - last_time
			$HoldNote.scale.z -= time_diff * 2.5 * SettingsAutoload.speed
			if $HoldNote.scale.z <= 0:
				queue_free()
			last_time = current_time
