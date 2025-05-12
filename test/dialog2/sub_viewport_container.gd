extends SubViewportContainer

@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	pass
	#get_shoot(get_tree().current_scene)

func get_shoot(node):
	for child in node.get_children():
		if child.name=="view":
			return
		if child is Sprite2D:
			sub_viewport.add_child(child.duplicate())
		else:
			get_shoot(child)
	await RenderingServer.frame_post_draw
	sub_viewport.get_texture().get_image().get_region(Rect2i(0, 0, 144, 81)).save_png("user://Screenshot1.png")
