extends Node3D

@export var collected = false

var xpos = 0
var zpos = 0
var type = 1

func _ready():
    position.x = xpos
    position.z = -zpos * (60 / float(TrackAutoload.bpm)) * SettingsAutoload.speed * 0.5

func collect():
    queue_free()