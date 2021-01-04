extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseOffsetX = 0
var mouseOffsetY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var touchCount = 0
var touchJustNow = false
func touch():
	return touchCount > 0
func touchNow():
	return touchJustNow
func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			touchCount += 1
			touchJustNow = true
		else:
			touchCount -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	touchJustNow = false
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("game_restart"):
		var _i = get_tree().reload_current_scene()
	if Input.is_action_just_pressed("game_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
