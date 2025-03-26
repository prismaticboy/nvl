extends Control

@export var save_path:String="user://saved_scene.tscn"

@export_group("UI")
@export var char_name:Label
@export var char_content:Label

@export_group("talk")
@export var dialog_day1:dialog_group=load("res://test/dialog/assert/day1_morning.tres")

var character_scene

var char_show=false

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
		
		for hide_name in dialog_1.hide:
			if has_node(str(hide_name)):
				get_node(str(hide_name)).queue_free()
					
		for show_name in dialog_1.show:
			if show_name !=null:
				var show_char=load("res://test/dialog/"+str(show_name)+".tscn").instantiate()
				show_char.set_name(show_name)
				add_child(show_char)
		if dialog_1.animation!=null and dialog_1.animation!="":	
			get_node(dialog_1.character_id+"/AnimationPlayer").play(dialog_1.animation)	
		
func _ready() -> void:
	diaplay_next_dialog()

	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		diaplay_next_dialog()


func _on_load_pressed() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://dialog.cfg")
	if result==OK:
		dialog_index=config.get_value("diaog","index")
	
	
	#if !FileAccess.file_exists("user://SavedGame.tscn"):
		#get_tree().change_scene_to_file("res://test/dialog/diag_UI.tscn")
	#else:
		#var new_scene = ResourceLoader.load("user://SavedGame.tscn").instantiate()
		#get_tree().get_root().add_child(new_scene)
		#self.queue_free()


func _on_save_pressed() -> void:
	var config = ConfigFile.new()
	config.set_value("diaog","index",dialog_index)
	config.save("user://dialog.cfg")	
	
	
	#var node_to_save=self
	#var scene = PackedScene.new()
	#scene.pack(node_to_save)
	#ResourceSaver.save(scene,"user://SavedGame.tscn")
		#
	pass # Replace with function body.
