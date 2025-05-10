extends CanvasLayer

@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport


func _ready() -> void:
	get_shoot(get_tree().current_scene)

func get_shoot(node):
	for child in node.get_children():
		print(child.name)
		if child.name=="view":
			return
		if child is Sprite2D:
			sub_viewport.add_child(child.duplicate())
		else:
			get_shoot(child)
	await RenderingServer.frame_post_draw
	sub_viewport.get_texture().get_image().get_region(Rect2i(0, 0, 288, 162)).save_png("user://Screenshot1.png")
