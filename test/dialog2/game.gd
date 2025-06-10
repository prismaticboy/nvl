extends CanvasLayer

var load_path = ""
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	self.hide()
	
func chang_scene(path,isLoad:bool=false):
	self.show()
	self.set_layer(999)
	animation_player.play("window_in")
	await animation_player.animation_finished
	if isLoad:
		load_path=path
		get_tree().change_scene_to_file("res://test/dialog2/load_page.tscn")
	else:
		if typeof(path)==TYPE_STRING:
			get_tree().change_scene_to_file(path)
		else:
			get_tree().change_scene_to_packed(path)
	animation_player.play_backwards("window_in")
	await animation_player.animation_finished
	self.hide()
	self.set_layer(-1)
