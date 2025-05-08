extends SubViewportContainer

@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"
@onready var _1_3_: Sprite2D = $"../1(3)"
@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	sub_viewport.add_child(_1_3_.duplicate())
	sub_viewport.add_child(sprite_2d_2.duplicate())
