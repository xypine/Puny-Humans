extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cursor = $Cursor

# Called when the node enters the scene tree for the first time.
func _ready():
#	cursor.set_as_toplevel(true)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var p = GlobalScreen.get_global_mouse_position() + InputExt.mouseOffset
	cursor.position = p


func _on_Save_pressed():
	GameData.saveConfig()


func _on_Load_pressed():
	GameData.loadConfig()
