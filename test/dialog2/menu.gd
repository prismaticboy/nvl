extends Control

@onready var menu: TextureRect = $menu
@onready var save: TextureRect = $save
@onready var load: TextureRect = $load
@onready var setting: TextureRect = $setting
@onready var log: TextureRect = $log
@onready var panel: Panel = $Panel

var pos_y=32
var pos_x=1016
var distance=60
var flag=false
var delay=0.0
func _ready() -> void:
	
	#menu.gui_input.connect(_on_gui_input.bind(menu))
	for bt in get_children():
		if bt is TextureRect:
			bt.gui_input.connect(_on_gui_input.bind(bt))
			bt.mouse_entered.connect(_on_mouse_entered.bind(bt))
			bt.mouse_exited.connect(_on_mouse_exited.bind(bt))
			bt.position.x=pos_x
			bt.position.y=pos_y
			pos_y+=distance
	menu_hide_init()
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

func _on_gui_input(event,node:TextureRect):
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT:
		if node.name=="menu":
			if flag==false:
				menu_hide()
			else:
				menu_show()
		if node.name=="save":
			if $"../save_ui".visible==false:
				$"../save_ui".show_save_menu()
				menu_hide()
			else:
				$"../save_ui".hide_save_menu()
		if node.name=="load":
			if $"../load_ui".visible==false:
				$"../load_ui".show_load_menu()
				menu_hide()
			else:
				$"../load_ui".hide_load_menu()
		if node.name=="log":
			if $"../log".visible==false:
				$"../log".show_log_menu()
				menu_hide()
			else:
				$"../log".hide_log_menu()
func menu_hide_init():
	for bt in get_children():
		if bt is TextureRect and bt.name!="menu":
			bt.position.x=pos_x+50
			bt.modulate.a=0
	flag=true
func menu_hide():
	var panel_tween = panel.create_tween()
	panel_tween.tween_property(panel,"size:y",50,0.1).set_ease(Tween.EASE_OUT)
	for bt in get_children():
		if bt is TextureRect and bt.name!="menu":
			bt.mouse_filter=TextureRect.MOUSE_FILTER_IGNORE
			var tween = bt.create_tween()
			tween.set_parallel(true)
			tween.tween_property(bt,"modulate:a",0
			,0.05).set_ease(Tween.EASE_OUT)
			tween.tween_property(bt,"position:x",pos_x+50
			,0.05).set_ease(Tween.EASE_OUT)
	flag=true		
func menu_show():
	delay=0.0
	var panel_tween = panel.create_tween()
	panel_tween.tween_property(panel,"size:y",300,0.2).set_ease(Tween.EASE_IN)
	for bt in get_children():
		if bt is TextureRect and bt.name!="menu":
			bt.mouse_filter=TextureRect.MOUSE_FILTER_STOP
			var tween = bt.create_tween()
			tween.set_parallel(true)
			tween.tween_property(bt,"modulate:a",1
			,0.05).set_delay(delay).set_ease(Tween.EASE_IN)
			tween.tween_property(bt,"position:x",pos_x
			,0.05).set_delay(delay).set_ease(Tween.EASE_IN)
			delay+=0.04
	flag=false		
