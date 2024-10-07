extends Node


var _viewport: Viewport


func _ready() -> void:
	_viewport = get_viewport()


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var delta: Vector2 = event.screen_relative / 100.0
		var pitch = Basis(Vector3.RIGHT, delta.y)
		var yaw = Basis(Vector3.UP, delta.x)
		var camera = %Camera3D.get_camera_transform().basis
		var trans = camera * yaw * pitch * camera.inverse()
		%Cube.basis = trans * %Cube.basis
		_viewport.set_input_as_handled()
