extends Control

@onready var content: Label = $Panel/content
@onready var charname: Label = $Panel/name
var dialog_index:int=1;

func _ready() -> void:
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
	var dialog_data=load_data(dialog_index)
	if dialog_index>dialog_data["max"]:
		return
	content.text=dialog_data[str(dialog_index)]["content"]
	charname.text=dialog_data[str(dialog_index)]["name"]
	dialog_index+=1

		
