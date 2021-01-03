extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var last = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Things.set_cellv(last, -1)
	var p = to_local(get_global_mouse_position())/.2
	var t = $TileMap.world_to_map(p)
	$Things.set_cellv(t, 0)
	last = t
	if Input.is_action_just_pressed("ui_grab"):
		print(p)
		print(t)
		print()
