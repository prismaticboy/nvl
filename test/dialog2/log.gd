extends Panel

var log_delay:float=0.1

@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready() -> void:
	visible=false
	z_index=0
	position=Vector2(50,50)
	pivot_offset=Vector2(size.x/2,size.y/2)
	scale=Vector2(1.2,1.2)
	modulate.a=0
	$Button.pressed.connect(hide_log_menu)

func show_log_menu():
	visible=true
	z_index=120
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"scale",Vector2(1,1)
	,log_delay).set_ease(Tween.EASE_IN)
	tween.tween_property(self,"modulate:a",1,
	log_delay).set_ease(Tween.EASE_IN)
	for index in range(1,get_tree().root.get_node("DialogUi").dialog_index):
		print(get_tree().root.get_node("DialogUi").dialog_data[str(index)]["name"])
		var label = Label.new()
		label.text = get_tree().root.get_node("DialogUi").dialog_data[str(index)]["content"]
		label.add_theme_font_size_override("font_size",24)
		label.custom_minimum_size = Vector2(850,0)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		v_box_container.add_child(label)
func hide_log_menu():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"scale",Vector2(1.2,1.2),
	log_delay).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"modulate:a",0,
	log_delay).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func():
		visible=false
		z_index=0).set_delay(0.5)
	await tween.finished
	for child in v_box_container.get_children():
		child.queue_free()
