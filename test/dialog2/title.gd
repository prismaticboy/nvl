extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("title_show")
	await animation_player.animation_finished
	animation_player.play("tip_show")
	
