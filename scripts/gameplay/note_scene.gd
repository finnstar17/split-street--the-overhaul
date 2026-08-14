extends Node3D

var xpos = 0
var zpos = 0
var type = 1

func _ready():
    global_position.x = xpos
    position.z = -zpos * (60 / float(TrackAutoload.bpm)) * TrackAutoload.speed * 0.5