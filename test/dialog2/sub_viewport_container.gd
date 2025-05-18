extends SubViewportContainer

@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	#get_shoot(get_tree().current_scene)
	pass
	

func get_shoot(node):
	for child in node.get_children():
		if child.name=="view":
			return
		if child is Sprite2D:
			sub_viewport.add_child(child.duplicate())
		else:
			get_shoot(child)
