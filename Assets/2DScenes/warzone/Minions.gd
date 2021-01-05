extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var minions = get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func getFreeM():
	for i in minions:
		if i.idle:
			return i
	return ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	minions = get_children()
	for i in minions:
		i.basePos = global_position
	if GameData.isGameOn and (Input.is_action_just_pressed("ui_grab") or InputExt.touch()):
		var pos = InputExt.mouse_pos()
		var m = getFreeM()
		if str(m) != "":
			m.target = pos
			m.idle = false
	elif Input.is_action_just_pressed("ui_grab"):
		print(GameData.isGameOn)
