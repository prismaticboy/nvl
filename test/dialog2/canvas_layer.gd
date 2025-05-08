extends CanvasLayer
@onready var sprite: Sprite2D = $"../Sprite"
@onready var player: Sprite2D = $"../player"
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

func _ready() -> void:
	sub_viewport.add_child(sprite.duplicate())
	sub_viewport.add_child(player.duplicate())

	await RenderingServer.frame_post_draw
	sub_viewport.get_texture().get_image().get_region(Rect2i(0, 0, 288, 162)).save_png("user://Screenshot1.png")
