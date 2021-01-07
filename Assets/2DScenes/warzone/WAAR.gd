extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var last = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Cursor.set_cellv(last, -1)
#	var v = GlobalScreen.get_viewport().size
#	var _view = Vector2(1920, 1080) / v
	var m = GlobalScreen.get_global_mouse_position() + InputExt.mouseOffset
	var p = (m)/$TileMap.scale.x #to_local, get_global_mouse_position()
	var t = $TileMap.world_to_map(p)
	$Cursor.set_cellv(t, 0)
	last = t
#	if Input.is_action_just_pressed("ui_grab"):
#		pass
#		print(v)
#		print(view)
#		print(t)
#		print()
