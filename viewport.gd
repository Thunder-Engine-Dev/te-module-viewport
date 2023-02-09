extends SubViewportContainer

@onready var vp = $SubViewport

func _ready() -> void:
	Thunder.stage_changed.connect(func():
		if !Thunder._current_stage.is_inside_tree(): return
		get_tree().root.remove_child.call_deferred(Thunder._current_stage)
		vp.add_child.call_deferred(Thunder._current_stage)
		_update_view()
	)

func _on_window_resized():
	_update_view()

func _update_view():
	if !vp: return
	
	var window_size = DisplayServer.window_get_size()
	material.set_shader_parameter(&"enable", scale != Vector2.ONE)
	scale.x = float(window_size.y) / float(vp.size.y)
	scale.y = float(window_size.y) / float(vp.size.y)
	vp.size.x = 480 * (float(window_size.x) / float(window_size.y))
	
