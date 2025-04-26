extends Control

signal save
signal load
var menu_bt_x:int=900
var menu_bt_y:int=0

@onready var menu_bt: Label = $menu_bt
@onready var save_bt: Label = $save_bt
@onready var load_bt: Label = $load_bt
@onready var exit_bt: Label = $exit_bt


func _ready() -> void:

	
	for bt in get_children():
		if bt is Label:
			bt.z_index=2
			bt.size=Vector2(200,100)
			bt.position=Vector2(menu_bt_x,menu_bt_y)
			bt.mouse_entered.connect(_mouse_enter.bind(bt))
			bt.mouse_exited.connect(_mouse_exit.bind(bt))
			menu_bt_y+=150

func _mouse_enter(node:Label):
	var tween = node.create_tween()
	tween.tween_property(node,"theme_override_styles/normal:bg_color"
	,Color(0.573, 0.776, 0.808)
	,0.2).set_ease(Tween.EASE_IN)
	#node.get("theme_override_styles/normal").bg_color=Color(0.573, 0.776, 0.808)
	#node.modulate = Color(0.369, 0.655, 0.702)
	#Color(0.573, 0.776, 0.808)
func _mouse_exit(node:Label):
	var tween = node.create_tween()
	tween.tween_property(node,"theme_override_styles/normal:bg_color"
	,Color(0.369, 0.655, 0.702)
	,0.2).set_ease(Tween.EASE_OUT)
