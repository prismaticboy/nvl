extends Panel


@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var number: Label = $number
@onready var dialog_data: Label = $dialog_data
@onready var time: Label = $time
@onready var texture_rect: TextureRect = $TextureRect

func _ready():
	#load_bt_status()
	self.gui_input.connect(_on_gui_input.bind(self))
	
func _on_gui_input(event,node:Panel):
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT:
		load_dialog()
		
func load_bt_status():
	var config=ConfigFile.new()
	var err = config.load("user://bt"+name+".cfg")
	if err!=OK:
		return
	number.text = config.get_value("bt", "number")
	dialog_data.text = config.get_value("bt", "dialog_data")
	time.text = config.get_value("bt", "time")
	
	var image = Image.load_from_file("user://"+self.name+".png")
	var texture = ImageTexture.create_from_image(image)
	texture_rect.texture = texture
	
	pass
func load_dialog():
	get_tree().root.get_node("DialogUi/menu").menu_hide()
	get_tree().root.get_node("DialogUi/load_ui").hide_load_menu()
	get_tree().root.get_node("DialogUi")._on_load_pressed(self.name)

	
