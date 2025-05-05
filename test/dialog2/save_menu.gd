extends Control


@onready var save: TextureRect = $save
@onready var load: TextureRect = $load
@onready var setting: TextureRect = $setting
@onready var log: TextureRect = $log


func _ready() -> void:
	for bt in get_children():
		if bt is TextureRect:
			bt.mouse_entered.connect(_on_mouse_entered.bind(bt))
			bt.mouse_exited.connect(_on_mouse_exited.bind(bt))
			
	pass

func _on_mouse_entered(node:TextureRect) -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(
		func(value):node.material.set_shader_parameter("clr",value),
		Color(1.0, 1.0, 1.0, 0.0),
		Color(1.0, 1.0, 1.0, 1.0),
		0.2
	).set_ease(Tween.EASE_IN)

func _on_mouse_exited(node:TextureRect) -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(
		func(value):node.material.set_shader_parameter("clr",value),
		Color(1.0, 1.0, 1.0, 1.0),
		Color(1.0, 1.0, 1.0, 0.0),
		0.2
	).set_ease(Tween.EASE_OUT)
