extends Control

signal save
signal load
var menu_bt_x:int=900
var menu_bt_y:int=0
var flag=false

@onready var menu_bt: Label = $menu_bt
@onready var save_bt: Label = $save_bt
@onready var load_bt: Label = $load_bt
@onready var exit_bt: Label = $exit_bt


func _ready() -> void:
	menu_bt.connect("gui_input",_menu_input)
	exit_bt.connect("gui_input",_exit_input)
	#menu_bt.gui_input.connect(_menu_input)
	
	_menu_hide()
	for bt in get_children():
		if bt is Label:
			bt.z_index=2
			bt.size=Vector2(100,50)
			bt.position=Vector2(menu_bt_x,menu_bt_y)
			bt.mouse_entered.connect(_mouse_enter.bind(bt))
			bt.mouse_exited.connect(_mouse_exit.bind(bt))
			menu_bt_y+=65

func _mouse_enter(node:Label):
	var tween = node.create_tween()
	tween.tween_property(node,"theme_override_styles/normal:bg_color"
	,Color(0.573, 0.776, 0.808)
	,0.1).set_ease(Tween.EASE_IN)

func _mouse_exit(node:Label):
	var tween = node.create_tween()
	tween.tween_property(node,"theme_override_styles/normal:bg_color"
	,Color(0.369, 0.655, 0.702)
	,0.2).set_ease(Tween.EASE_OUT)
	
func _menu_show():
	var delay:float=0
	flag=false
	for bt in get_children():
		if bt is Label and bt.name!="menu_bt":
			var tween = bt.create_tween()
			tween.set_parallel(true)
			tween.tween_property(bt,"position:x"
			,900,0.04).set_delay(delay).set_ease(tween.EASE_IN)
			tween.tween_property(bt,"modulate:a"
			,1,0.04).set_delay(delay).set_ease(tween.EASE_IN)
			bt.mouse_filter=Label.MOUSE_FILTER_STOP
			delay+=0.04

func _menu_hide():
	var delay:float=0
	flag=true
	for bt in get_children():
		if bt is Label and bt.name!="menu_bt":
			var tween = bt.create_tween()
			tween.set_parallel(true)
			tween.tween_property(bt,"position:x"
			,950,0.04).set_delay(delay).set_ease(tween.EASE_OUT)
			tween.tween_property(bt,"modulate:a"
			,0,0.04).set_delay(delay).set_ease(tween.EASE_OUT)
			bt.mouse_filter=Label.MOUSE_FILTER_IGNORE
			delay+=0.04

func _menu_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT:
		if flag:
			_menu_show()
		else:
			_menu_hide()
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_RIGHT:
		if flag==false:
			_menu_hide()		
			
func _exit_input(event):
	if (event is InputEventScreenTouch and event.pressed) or (event is InputEventMouseButton and event.pressed):
		get_tree().quit()
