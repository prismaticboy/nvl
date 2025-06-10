extends Control
class_name dialog_scene
@onready var CHAR = preload("res://test/dialog2/char.tscn")
@onready var BG = preload("res://test/dialog2/background.tscn")
@onready var dialog_ui: Control = $"."
@onready var bgm: AudioStreamPlayer = $BGM
@onready var content: Label = $Panel/content
@onready var charname: Label = $Panel/name
@onready var panel: Panel = $Panel

var dialog_index:int=1;
@onready var dialog_data=load_data(dialog_index)
@onready var char_list=["libai","dufu"]
@onready var current_list=[]
var type_tween:Tween

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
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		$menu.menu_hide()
#显示下一个对话
func diaplay_next_dialog():
	if dialog_index>dialog_data["max"]:
		return
	if type_tween and type_tween.is_running():
		type_tween.kill()
		content.text = dialog_data[str(dialog_index)]["content"]
		dialog_index+=1
		return
	$menu.menu_hide()
	show_bg()
	show_char()
	show_animation()
	play_music()
	show_dialog()
	
func show_char():
	var new_char=CHAR.instantiate()
	var hide:String=dialog_data[str(dialog_index)]["hide"]
	var char_name:String=dialog_data[str(dialog_index)]["char"]
	var pos:String=dialog_data[str(dialog_index)]["pos"]
	var emotion:String=dialog_data[str(dialog_index)]["emotion"]
	var animation:String=dialog_data[str(dialog_index)]["animation"]
	var bg_animation = dialog_data[str(dialog_index)]["bg_animation"]
	var node_name:Array=[]
	

	match pos:
		"left":
			new_char.position=Vector2(400,350)
		"center":
			new_char.position=Vector2(600,350)
		"right":
			new_char.position=Vector2(800,350)	
	
	new_char.get_child(0).texture=load("res://"+emotion)
	new_char.get_child(0).z_index=8
	new_char.modulate.a=0
	new_char.name=char_name
	#add_child(char)
	for node in get_children():
		node_name.append(node.name)
		if node.name==hide:
			var tween=node.create_tween()
			tween.tween_property(node,"modulate:a",0,0.2).set_ease(Tween.EASE_OUT)
			tween.tween_callback(func():node.queue_free())
	if node_name.find(char_name)==-1:
		add_child(new_char)
		var tween=new_char.create_tween()
		tween.tween_property(new_char,"modulate:a",1,0.2)
			
	match hide:
		"action":
			for action in get_children():
				if action.name==char_name:
					action.name="old"
					add_child(new_char)
					var tween=new_char.create_tween()
					tween.set_parallel(true)					
					tween.tween_property(new_char,"modulate:a",1,0.2).set_ease(Tween.EASE_IN)
					tween.tween_property(action,"modulate:a",0,0.2).set_ease(Tween.EASE_OUT)
					tween.tween_callback(func():action.queue_free()).set_delay(0.2)
					break
			pass
		"emotion":
			for action in get_children():
				if action.name==char_name:
					action.name="old"
					add_child(new_char)
					var tween=new_char.create_tween()
					tween.tween_property(new_char,"modulate:a",1,0.2).set_ease(Tween.EASE_IN)
					tween.tween_callback(func():action.queue_free()).set_delay(0.2)
			pass

func show_animation():
	var animation:String=dialog_data[str(dialog_index)]["animation"]
	var char_name:String=dialog_data[str(dialog_index)]["char"]
	if animation!="":
		get_node(char_name).get_node("AnimationPlayer").play(animation)


func play_music():
	var music:String=dialog_data[str(dialog_index)]["music"]

	if music!="" and bgm.stream.resource_path!=music: 
		var stop_tween = bgm.create_tween()
		stop_tween.tween_property(bgm,"volume_db",-10,1.5).set_ease(Tween.EASE_OUT)
		bgm.stop()
		if music!="stop":
			bgm.stream=load("res://"+music)
			bgm.play()
			bgm.volume_db=-10
			var start_tween = bgm.create_tween()
			start_tween.tween_property(bgm,"volume_db",0,1.5).set_ease(Tween.EASE_IN)
			
func show_bg():
	var background:String = dialog_data[str(dialog_index)]["bg"]
	var bg_animation:String = dialog_data[str(dialog_index)]["bg_animation"]
	var node_name:Array=[]
	for node in get_children():
		node_name.append(node.name)
		if node.name=="background" and background!="":
			node.get_node("AnimationPlayer").play(bg_animation)
			await get_tree().create_timer(0.2).timeout
			node.get_child(0).texture=load("res://"+background)	
			break
	if node_name.find("background")==-1:
		var new_bg=BG.instantiate()
		new_bg.name="background"
		new_bg.get_child(0).texture=load("res://"+background)
		add_child(new_bg)
		new_bg.get_node("AnimationPlayer").play(bg_animation)

func show_dialog():
	var content_data = dialog_data[str(dialog_index)]["content"]
	var char_data = dialog_data[str(dialog_index)]["name"]
	content.text=""
	charname.text = char_data

	if dialog_data[str(dialog_index)]["bg_animation"]!="":	
		panel.scale=Vector2(0.8,0.8)
		panel.modulate.a=0
		dialog_ui.mouse_filter=Control.MOUSE_FILTER_STOP
		await get_tree().create_timer(1).timeout
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(panel,"scale",Vector2(1,1),0.2).set_ease(Tween.EASE_IN)
		tween.tween_property(panel,"modulate:a",1,0.2).set_ease(Tween.EASE_IN)
		tween.tween_callback(func():dialog_ui.mouse_filter=Control.MOUSE_FILTER_IGNORE)
	type_tween=get_tree().create_tween()
	for character in content_data:
		type_tween.tween_callback(func():content.text+=character).set_delay(0.02)
	type_tween.tween_callback(func():dialog_index+=1)


func _on_save_pressed(slot:String) -> void:
	var config=ConfigFile.new()
	current_list=[]
	config.set_value("game", "index", dialog_index)
	config.set_value("game", "bg" ,get_node("background").get_child(0).texture)
	config.set_value("game", "bgm" ,get_node("BGM").stream)
	config.set_value("game", "bgm_play" ,get_node("BGM").playing)
	config.set_value("game", "name",charname.text)
	config.set_value("game", "content",content.text)
	for list in get_children():
		if char_list.find(list.name)	!=-1:
			current_list.append(str(list.name))
			config.set_value(str(list.name),"pos",list.position)
			config.set_value(str(list.name),"texture",list.get_child(0).texture)
	config.set_value("char","name",current_list)
	config.save("user://dialog"+slot+".cfg")

func _on_load_pressed(slot:String) -> void:
	
	dialog_ui.mouse_filter=Control.MOUSE_FILTER_STOP
	
	var config=ConfigFile.new()
	var err = config.load("user://dialog"+slot+".cfg")
	dialog_index = config.get_value("game", "index")
	

	var in_tween=get_tree().create_tween()
	in_tween.tween_property(get_node("background").get_node("ColorRect"),"color:a",1,0.25).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.3).timeout
	
	get_node("background").get_child(0).texture = config.get_value("game", "bg")
	get_node("BGM").stream=config.get_value("game", "bgm")
	content.text = config.get_value("game", "content")	
	charname.text = config.get_value("game", "name")	
		
	current_list=config.get_value("char","name")
	for list in get_children():
		if char_list.find(list.name)	!=-1:
			list.queue_free()
		if list.name=="old":
			list.queue_free()

	for list_name in current_list:
		var new_char = CHAR.instantiate()
		new_char.position=config.get_value(list_name,"pos")
		new_char.get_child(0).texture=config.get_value(list_name,"texture")
		new_char.modulate.a=0
		add_child(new_char)
		var show_tween = new_char.create_tween()
		show_tween.tween_property(new_char,"modulate:a",1,0.2).set_ease(Tween.EASE_IN)
		show_tween.tween_callback(func():new_char.name=str(list_name))
	
	bgm.volume_db=-10
	bgm.playing=config.get_value("game","bgm_play")
	var tween = bgm.create_tween()
	tween.tween_property(bgm,"volume_db",0,1.5).set_ease(Tween.EASE_IN)
	
	var out_tween=get_tree().create_tween()
	out_tween.tween_property(get_node("background").get_node("ColorRect"),"color:a",0,0.2).set_ease(Tween.EASE_IN)
	await get_tree().create_timer(0.25).timeout
	
	dialog_ui.mouse_filter=Control.MOUSE_FILTER_IGNORE
	
