extends Control
var x1=20
var x2=480
var y1=200
var y2=140
var current_page=1
var pos:Array=[
	Vector2(x1,y1),Vector2(x1+x2,y1),
	Vector2(x1,y1+y2),Vector2(x1+x2,y1+y2),
	Vector2(x1,y1+y2*2),Vector2(x1+x2,y1+y2*2)
]

var SAVE_BT=preload("res://test/dialog2/save_bt.tscn")

func _ready() -> void:
	
	for p in pos:
		var save_bt=SAVE_BT.instantiate()
		save_bt.position = p
		#var SAVE_BT=SAVE.instantiate()
		add_child(save_bt)
	for bt in get_children():
		var bt_num=0
		if bt is Panel and bt.name!="save_bg":
			bt_num=current_page*6+(bt_num+1)
			bt.name=str(bt_num)
			bt.get_node("number").text="NO."+bt.name
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",1,0.2)
