extends Control

signal save
signal load

func _ready() -> void:
	var pos_x=20;
	for child in get_children():
		if child is Button:
			child.size=Vector2(150,60)
			child.position=Vector2(980,pos_x)
			pos_x+=80
	for bt in get_children():
		if bt is Button and bt.name!="menu":
			bt.position.x=1200
			bt.mouse_filter=Control.MOUSE_FILTER_IGNORE
			
func _on_menu_pressed() -> void:
	if $quit.position.x==1200:
		var delay = 0
		for bt in get_children():
			if bt is Button and bt.name!="menu":
				var tween = bt.create_tween()
				tween.tween_property(bt,"position:x",980
				,0.075).set_ease(Tween.EASE_IN).set_delay(delay)
				delay+=0.03
				tween.tween_callback(func():bt.mouse_filter=Control.MOUSE_FILTER_STOP)
	else:
		var delay = 0
		for bt in get_children():
			if bt is Button and bt.name!="menu":
				var tween = bt.create_tween()
				tween.tween_property(bt,"position:x",1200
				,0.075).set_ease(Tween.EASE_OUT).set_delay(delay)
				delay+=0.03
				tween.tween_callback(func():bt.mouse_filter=Control.MOUSE_FILTER_IGNORE)


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_save_pressed() -> void:
	emit_signal("save")
	pass # Replace with function body.


func _on_load_pressed() -> void:
	emit_signal("load")
	pass # Replace with function body.
