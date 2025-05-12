extends Control
var x1=20
var x2=480
var y1=200
var y2=140
var pos:Array=[
	Vector2(x1,y1),Vector2(x1+x2,y1),
	Vector2(x1,y1+y2),Vector2(x1+x2,y1+y2),
	Vector2(x1,y1+y2*2),Vector2(x1+x2,y1+y2*2)
]



func _ready() -> void:
	
	for p in pos:
		var SAVE_BT=load("res://test/dialog2/save_bt.tscn").instantiate()
		SAVE_BT.position = p
		#var SAVE_BT=SAVE.instantiate()
		add_child(SAVE_BT)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",1,0.2)
