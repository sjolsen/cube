extends Node3D


const _cubie: Script = preload("res://cubie/cubie.gd")
const _center: ArrayMesh = preload("res://cubie/center.res")
const _corner: ArrayMesh = preload("res://cubie/corner.res")
const _edge: ArrayMesh = preload("res://cubie/edge.res")


func _instantiate(mesh: ArrayMesh, trans: Transform3D):
	var node = _cubie.new(mesh, trans)
	add_child(node)


func _ready() -> void:
	# The placeholder is just for the editor view
	$PlaceholderMesh.visible = false

	# Rotating around the diagonal is a convenient way to iterate over the three
	# primary axes
	var diagonal = Vector3(1, 1, 1).normalized()

	# The center cubie faces -X
	const center_transform = Transform3D(Basis(), Vector3(-1, 0, 0))
	for i in range(2):
		var trans = center_transform.rotated(Vector3.UP, i * TAU / 2)
		for j in range(3):
			_instantiate(_center, trans.rotated(diagonal, j * TAU / 3))

	# The edge cubie faces -X and -Z
	const edge_transform = Transform3D(Basis(), Vector3(-1, 0, -1))
	for i in range(4):
		var trans = edge_transform.rotated(Vector3.UP, i * TAU / 4)
		for j in range(3):
			_instantiate(_edge, trans.rotated(diagonal, j * TAU / 3))

	# The corner cubie faces -X, +Y, -Z
	const corner_transform = Transform3D(Basis(), Vector3(-1, 1, -1))
	for i in range(4):
		var trans = corner_transform.rotated(Vector3.UP, i * TAU / 4)
		for j in range(2):
			_instantiate(_corner, trans.rotated(Vector3.RIGHT, j * TAU / 2))


func _process(delta: float) -> void:
	pass
