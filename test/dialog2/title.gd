extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tip: Label = $TextureRect/tip

func _ready() -> void:
	animation_player.play("tip_show")
	gui_input.connect(_on_click)
	$Button.pressed.connect(start_game)
func _on_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT:
		animation_player.stop()
		animation_player.play("title_hide")
		var tween = tip.create_tween()
		tween.tween_property(tip,"modulate:a",0,0.2)
func start_game():
	Game.chang_scene("res://test/dialog2/dialog_ui.tscn",true)
	
