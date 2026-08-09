extends Node

@onready var inputs = get_children()
var notes = {}

func _ready():
	for input in inputs:
		print(input.get_meta("Note"))
		notes[input.get_meta("Note")] = input

func _input(event):
	if event is InputEventKey:
		var key = "gp_" + event.as_text_keycode().to_lower()
		if key in notes:
			var note = notes[key]
			if event.pressed:
				print("pressed: " + key)
				print(note)

				note.get_node("MeshInstance3D").material_override.albedo_color = Color(0.25, 0.25, 0.25)
			else:
				print("released: " + key)
				print(note)

				note.get_node("MeshInstance3D").material_override.albedo_color = Color(0, 0, 0)
