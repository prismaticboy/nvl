extends Control

signal save
signal load
var show_pos:int = 980
var hide_pos:int = 1200

@onready var menu_bt: Button = $menu


func _ready() -> void:
	var pos_x=20;
	$TextureRect.size = Vector2(300,150)

	$TextureRect.mouse_entered.connect(_modulate_half)
	$TextureRect.mouse_exited.connect(_modulate_one)
	$TextureRect.gui_input.connect(_on_ui_input)
	for child in get_children():
		if child is Button:
			child.size=Vector2(120,50)
			child.position=Vector2(show_pos,pos_x)
			child.modulate = Color(0.699, 0.699, 0.699)
			child.button_down.connect(_down_animation.bind(child))
			child.button_up.connect(_up_animation.bind(child))
			pos_x+=80
	for bt in get_children():
		if bt is Button and bt.name!="menu":
			bt.position.x=hide_pos
			bt.mouse_filter=Control.MOUSE_FILTER_IGNORE
			
func _on_menu_pressed() -> void:
	if $quit.position.x==hide_pos:
		var delay = 0
		for bt in get_children():
			if bt is Button and bt.name!="menu":
				var tween = bt.create_tween()
				tween.tween_property(bt,"position:x",show_pos
				,0.075).set_ease(Tween.EASE_IN).set_delay(delay)
				delay+=0.03
				tween.tween_callback(func():bt.mouse_filter=Control.MOUSE_FILTER_STOP)
	else:
		var delay = 0
		for bt in get_children():
			if bt is Button and bt.name!="menu":
				var tween = bt.create_tween()
				tween.tween_property(bt,"position:x",hide_pos
				,0.075).set_ease(Tween.EASE_OUT).set_delay(delay)
				delay+=0.03
				tween.tween_callback(func():bt.mouse_filter=Control.MOUSE_FILTER_IGNORE)
func button_hide():
	for bt in get_children():
		if bt is Button:
			var hide_tween = bt.create_tween()
			hide_tween.tween_property(bt,"modulate:a",0,0.2).set_ease(Tween.EASE_OUT)
			bt.mouse_filter=Control.MOUSE_FILTER_IGNORE
	#await get_tree().create_timer(1).timeout			
func button_show():
	for bt in get_children():
		if bt is Button and bt.name!="menu":
			bt.position.x=hide_pos
			bt.mouse_filter=Control.MOUSE_FILTER_STOP
			bt.modulate.a=1
	var menu_bt_tween=menu_bt.create_tween()
	menu_bt_tween.tween_property(menu_bt,"modulate:a",1,0.2)
	menu_bt.mouse_filter=Control.MOUSE_FILTER_STOP	
func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_save_pressed() -> void:
	#print(Time.get_datetime_dict_from_system())
	emit_signal("save")
	pass # Replace with function body.


func _on_load_pressed() -> void:
	emit_signal("load")
	pass # Replace with function body.

func _down_animation(bt:Button):
	bt.modulate=Color(1.0, 1.0, 1.0)

func _up_animation(bt:Button):
	bt.modulate=Color(0.699, 0.699, 0.699)

func _modulate_half():
	$TextureRect.modulate.a=0.5
func _modulate_one():
	$TextureRect.modulate.a=1
func _on_ui_input(event:InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		$TextureRect.modulate.a=1
		print("hello")
	pass
