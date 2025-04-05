extends Control

@onready var CHAR = preload("res://test/dialog2/char.tscn")
@onready var bgm: AudioStreamPlayer = $BGM
@onready var content: Label = $Panel/content
@onready var charname: Label = $Panel/name
var dialog_index:int=1;
@onready var dialog_data=load_data(dialog_index)

func _ready() -> void:
	diaplay_next_dialog()

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

	show_char()
	play_music()
	content.text=dialog_data[str(dialog_index)]["content"]
	charname.text=dialog_data[str(dialog_index)]["name"]
	dialog_index+=1


func show_char():
	var new_char=CHAR.instantiate()
	var hide:String=dialog_data[str(dialog_index)]["hide"]
	var char_name:String=dialog_data[str(dialog_index)]["char"]
	var pos:String=dialog_data[str(dialog_index)]["pos"]
	var emotion:String=dialog_data[str(dialog_index)]["emotion"]
	var animation:String=dialog_data[str(dialog_index)]["animation"]
	var node_name:Array=[]

	match pos:
		"left":
			new_char.position=Vector2(200,350)
		"center":
			new_char.position=Vector2(600,350)
		"right":
			new_char.position=Vector2(1000,350)	
	
	new_char.get_child(0).texture=load("res://"+emotion)
	new_char.modulate.a=0
	new_char.name=char_name
	#add_child(char)
	for node in get_children():
		node_name.append(node.name)
		if node.name==hide:
			var tween=node.create_tween()
			tween.tween_property(node,"modulate:a",0,0.2).set_ease(Tween.EASE_OUT)
			tween.tween_callback(func():node.queue_free())
				
			
	match hide:
		"action":
			for action in get_children():
				if action.name==char_name:
					action.name="old"
					add_child(new_char)
					var tween=new_char.create_tween()
					tween.set_parallel(true)					
					tween.tween_property(new_char,"modulate:a",1,0.2)
					tween.tween_property(action,"modulate:a",0,0.2)
					tween.tween_callback(func():action.queue_free()).set_delay(0.2)
					break
			pass
		"emotion":
			for action in get_children():
				if action.name==char_name:
					action.name="old"
					add_child(new_char)
					var tween=new_char.create_tween()
					tween.tween_property(new_char,"modulate:a",1,0.2)
					tween.tween_callback(func():action.queue_free())
			pass
		"no":
			if node_name.find(char_name)==-1:
				add_child(new_char)
				var tween=new_char.create_tween()
				tween.tween_property(new_char,"modulate:a",1,0.2)


func play_music():
	var audio:String=dialog_data[str(dialog_index)]["music"]
	if audio!="":
		bgm.stop()
		if audio!="stop":
			bgm.stream=load("res://"+audio)
			bgm.play()
func show_bg():
	pass
