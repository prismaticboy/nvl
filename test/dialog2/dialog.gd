extends Control

var CHAR = preload("res://test/dialog2/char.tscn")
@onready var bgm: AudioStreamPlayer = $BGM
@onready var content: Label = $Panel/content
@onready var charname: Label = $Panel/name
var dialog_index:int=1;
var dialog_data
func _ready() -> void:
	dialog_data=load_data(dialog_index)
	diaplay_next_dialog()

	pass
#加载json数据	
func load_data(index:int):
	var file_path = "res://test/dialog2/assert/dialog_data/day1.json"
	var json_content = load_json_file(file_path)
	var data=parse_json(json_content)
	return data
	
func load_json_file(path:String):
	var file = FileAccess.open(path,FileAccess.READ)
	var content=file.get_as_text()
	file.close()
	return content
		
func parse_json(json_string:String):
	var json=JSON.new()
	var error = json.parse(json_string)
	if error==OK:
		return json.data		

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		diaplay_next_dialog()
#显示下一个对话
func diaplay_next_dialog():
	
	if dialog_index>dialog_data["max"]:
		return
	for i in get_children():
		if dialog_data[str(dialog_index)]["hide"]=="" and i.name!=dialog_data[str(dialog_index)]["char"]:
			show_char(dialog_data[str(dialog_index)]["pos"],dialog_data[str(dialog_index)]["emotion"],dialog_data[str(dialog_index)]["char"])
			break
		else:
			if i.name==dialog_data[str(dialog_index)]["hide"]:
				i.queue_free()
				
	if dialog_data[str(dialog_index)]["music"]!="":
		play_music(dialog_data[str(dialog_index)]["music"])
	content.text=dialog_data[str(dialog_index)]["content"]
	charname.text=dialog_data[str(dialog_index)]["name"]
	dialog_index+=1


func show_char(pos:String,emotion:String,char_name:String):
	var char=CHAR.instantiate()
	match pos:
		"left":
			char.position=Vector2(200,350)
		"center":
			char.position=Vector2(600,350)
		"right":
			char.position=Vector2(1000,350)	
	char.name=char_name		
	add_child(char)
	pass
func play_music(audio:String):
	bgm.stop()
	bgm.stream=load("res://"+audio)
	bgm.play()
	pass		
