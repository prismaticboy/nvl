extends Control



@export_group("UI")
@export var char_name:Label
@export var char_content:Label

@export_group("talk")
@export var dialog_day1:dialog_group

var dialog_index=0
var type_time = 0.025
var type_tween:Tween

func diaplay_next_dialog():

	if dialog_index>=len(dialog_day1.dialog_list):
		visible = false
		return
	var dialog_1:=dialog_day1.dialog_list[dialog_index]
	char_content.visible_ratio=0
	char_name.text=dialog_1.character_name
	char_content.text=dialog_1.content
	
	if type_tween and type_tween.is_running():
		type_tween.kill()
		char_content.visible_ratio=1
		dialog_index+=1
	else:
		char_content.visible_ratio=0
		type_tween = get_tree().create_tween()
		type_tween.tween_property(char_content,"visible_ratio",1,type_time*char_content.text.length())
		type_tween.tween_callback(func():dialog_index+=1)
		
	
	
	
	
	
	#dialog_index+=1
	
func _ready() -> void:
	diaplay_next_dialog()
	

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
			diaplay_next_dialog()
