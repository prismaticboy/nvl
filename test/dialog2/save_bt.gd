extends Panel

func _ready():
	
	self.gui_input.connect(_on_gui_input.bind(self))
	
func _on_gui_input(event,node:Panel):
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT:
		update_bt_status()
		save_bt_status()
		
func get_content():
	var content=get_tree().current_scene.get_node("Panel/content")
	if content==null:
		return
	else:
		$dialog_data.max_lines_visible=2
		$dialog_data.clip_text=true
		$dialog_data.text=content.text
		
func update_bt_status():
	$SubViewportContainer.get_shoot(get_tree().current_scene)
	var time = Time.get_datetime_dict_from_system()
	$time.text = "时间:"+str(time.year)+"-"+str(time.month)+"-"+str(time.day)+" "+str(time.hour)+":"+str(time.minute)+":"+str(time.second)
	get_content()	
	
func save_bt_status():
	var config=ConfigFile.new()
	config.set_value("bt", "number", $number.text)
	config.set_value("bt", "dialog_data", $dialog_data.text)
	config.set_value("bt", "time", $time.text)
	await RenderingServer.frame_post_draw
	$SubViewportContainer/SubViewport.get_texture().get_image().get_region(Rect2i(0, 0, 144, 81)).save_png("user://"+self.name+".png")
	config.save("user://bt"+name+".cfg")

func load_bt_status():
	pass
