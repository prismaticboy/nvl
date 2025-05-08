extends Panel


func _ready():
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().get_region(Rect2i(0, 0, 1152, 648)).save_png("user://Screenshot.png")
