extends Node2D

@onready var loading: Sprite2D = $Node2D/Loading
@onready var label: Label = $Node2D/Label
@onready var node_2d: Node2D = $Node2D


var load_status = 0
var progress = []
func _ready() -> void:
	node_2d.modulate.a = 0
	var tween = node_2d.create_tween()
	tween.tween_property(node_2d,"modulate:a",1,0.5)
	ResourceLoader.load_threaded_request(Game.load_path)
	
func _physics_process(delta: float) -> void:
	load_status = ResourceLoader.load_threaded_get_status(Game.load_path,progress)
	if load_status==ResourceLoader.THREAD_LOAD_LOADED:
		set_physics_process(false)
		await get_tree().create_timer(0.5).timeout
		Game.chang_scene(ResourceLoader.load_threaded_get(Game.load_path))
