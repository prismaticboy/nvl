extends TextureRect


@export var button_text:String = ""

func _ready() -> void:
	$Label.text = button_text
