extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
func _process(delta):
	touchJustNow = false
