extends SubViewportContainer

@onready var sub_viewport: SubViewport = $SubViewport
	
func get_shoot(node):
	for child in node.get_children():
		if child.name=="view":
			return
		if child is Sprite2D:
			sub_viewport.add_child(child.duplicate())
		else:
			get_shoot(child)
