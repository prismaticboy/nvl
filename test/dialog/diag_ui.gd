extends Control

@export_group("UI")
@export var char_name:Label
@export var char_content:Label

@export_group("talk")
@export var dialog_day1:dialog_group

var dialog_index=0

func diaplay_next_dialog():
	var dialog_1:=dialog_day1.dialog_list[dialog_index]
	char_name.text=dialog_1.character_name
	char_content.text=dialog_1.content
	
	dialog_index+=1
	
func _ready() -> void:
	diaplay_next_dialog()
	

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		diaplay_next_dialog()
