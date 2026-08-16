extends Node3D

@onready var bottomRoad = $BottomRoad
@onready var topRoad = $TopRoad
var notes = {}

func _ready():
	var bottomInputs = bottomRoad.get_children()
	var topInputs = topRoad.get_children()
	var inputs = []

	for input in bottomInputs:
		if input.name.length() == 1:
			inputs.append(input)
	for input in topInputs:
		if input.name.length() == 1:
			inputs.append(input)
	for input in inputs:
		notes[input.get_meta("Note")] = input

	TrackAutoload.inputs = inputs

func _input(event):
	if event is InputEventKey:
		var key = "gp_" + event.as_text_keycode().to_lower()
		if key in notes:
			var note = notes[key]
			var hit_mesh = note.get_node("HitMesh")
			var glow_mesh = note.get_node("GlowMesh")
			var meshes = [hit_mesh, glow_mesh]

			if event.pressed:
				set_color(meshes, 0.6)
				note.set_meta("active", true)
				note.press_time = (Time.get_ticks_msec()) / 1000.0
				# print("pressed " + str(note.press_time))
				note.check_notes()
			else:
				set_color(meshes, 0.15)
				note.set_meta("active", false)
				note.end_time = (Time.get_ticks_msec()) / 1000.0

func set_color(meshes : Array, value : float):
	for mesh in meshes:
		mesh.material_override.albedo_color = Color(value, value, value)
