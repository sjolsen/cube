extends MeshInstance3D


const _directions: Array[Vector3] = [
	Vector3.RIGHT,
	Vector3.LEFT,
	Vector3.UP,
	Vector3.DOWN,
	Vector3.BACK,
	Vector3.FORWARD,
]

const _colors: Array[Vector2i] = [
	Vector2i(2, 1), # YELLOW
	Vector2i(0, 1), # WHITE
	Vector2i(1, 0), # RED
	Vector2i(1, 2), # ORANGE
	Vector2i(1, 1), # GREEN
	Vector2i(3, 1), # BLUE
]

func _init(amesh: ArrayMesh, trans: Transform3D):
	# Remap the UVs for the stickers
	var arrays = amesh.surface_get_arrays(0)
	var normals: PackedVector3Array = arrays[mesh.ARRAY_NORMAL]
	var uvs: PackedVector2Array = arrays[mesh.ARRAY_TEX_UV]
	for i in range(uvs.size()):
		if uvs[i].x > 0.25 || uvs[i].y > 0.25:
			var normal = trans.basis * normals[i]
			var best_dot = 0.0
			var best_color = Vector2i(0, 0) # BLACK
			for j in range(6):
				var dot = normal.dot(_directions[j])
				if dot > best_dot:
					best_dot = dot
					best_color = _colors[j]
			uvs[i] = Vector2(
					0.125 + best_color.x * 0.25,
					0.125 + best_color.y * 0.25)

	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh.surface_set_material(0, amesh.surface_get_material(0))
	transform = trans
