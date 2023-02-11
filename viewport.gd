extends SubViewportContainer

@onready var vp = $SubViewport

func _ready() -> void:
	resized.connect(_on_window_resized)
	#get_tree().root.audio_listener_enable_2d = false
	
	#Scenes.install_scene()
	#
	add_viewport.call_deferred()
	Scenes.scene_changed_notification.connect(add_viewport)
	
	#Audio._calculate_player_position = func(ref: Node2D) -> Vector2:
	#	return ref.global_position - vp.get_camera_2d().global_position + Vector2(vp.size / 2)

func add_viewport():
	if !Scenes.current_scene: return
	if !Scenes.current_scene.is_inside_tree(): return
	get_tree().root.remove_child.call_deferred(Scenes.current_scene)
	vp.add_child.call_deferred(Scenes.current_scene)
	Scenes.current_root = vp
	_update_view()

func _on_window_resized():
	_update_view()


func _update_view() -> void:
	if !vp: return
	
	var window_size = DisplayServer.window_get_size()
	scale.x = float(window_size.y) / float(vp.size.y)
	scale.y = float(window_size.y) / float(vp.size.y)
	material.set_shader_parameter(&"enable", scale.y != 1)
	vp.size.x = 480 * (float(window_size.x) / float(window_size.y))
	
