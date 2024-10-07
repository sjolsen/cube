extends Node


var _viewport: Viewport


func _ready() -> void:
	_viewport = get_viewport()


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var cam_basis: Basis = %Camera3D.get_camera_transform().basis
		var cube_basis: Basis = cam_basis.inverse() * %Cube.basis
		var delta: Vector2 = event.screen_relative / 100.0
		cube_basis = cube_basis.rotated(Vector3.RIGHT, delta.y)
		cube_basis = cube_basis.rotated(Vector3.UP, delta.x)
		%Cube.basis = cam_basis * cube_basis
		_viewport.set_input_as_handled()
