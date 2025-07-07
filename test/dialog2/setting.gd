extends Control


@onready var panel: Panel = $Panel

var pos_y = 0
var pos_x = 25
var pos_distance = 60

var bt_y = 100
var bt_x = 25
var bt_distance = 60

func _ready() -> void:
	$Panel/windows_bt.pressed.connect(_on_screen_pressed)
	for child in panel.get_children():
		if child is Label:
			child.add_theme_color_override("font_color",Color(0.85, 0.882, 0.938, 0.784))
			child.add_theme_font_size_override("font_size",40)
			pos_y+=pos_distance
			child.position.y = pos_y
			child.position.x = pos_x
		if child is Button:
			bt_y+=bt_distance
			child.position.y = bt_y
			child.position.x = bt_x
			child.set_custom_minimum_size(Vector2(100,50))

func _on_screen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
