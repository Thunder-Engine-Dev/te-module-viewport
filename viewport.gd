extends SubViewportContainer

@onready var vp = $SubViewport

var current_pixel_scale = 1.0

func _ready() -> void:
	Thunder.stage_changed.connect(func():
		get_tree().root.remove_child.call_deferred(Thunder._current_stage)
		vp.add_child.call_deferred(Thunder._current_stage)
		get_tree().set_deferred("current_scene", Thunder._current_stage)
	)

func _on_window_resized():
	_update_view()

func _update_view():
	if !vp: return
	
	var window_size = DisplayServer.window_get_size()
	scale = Vector2(window_size) / Vector2(vp.size)
