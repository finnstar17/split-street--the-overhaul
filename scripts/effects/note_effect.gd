extends Node3D

@onready var ring = $Ring
@onready var scale_mesh = $Ring/ScaleMesh
@onready var fade_mesh = $FadeMesh

var duration = 0.3

func _ready():
	tween_fade(scale_mesh)
	tween_fade(fade_mesh)

	var scale_tween = ring.create_tween()
	scale_tween.set_ease(Tween.EASE_OUT)
	scale_tween.set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(ring, "scale", Vector3(1.5, 1.5, 1.5), duration)

	scale_tween.finished.connect(func():
		queue_free()	
	)

func tween_fade(mesh : MeshInstance3D):
	var material = mesh.material_override
	var tween = create_tween()
	tween.tween_property(material, "albedo_color", Color(), duration)
