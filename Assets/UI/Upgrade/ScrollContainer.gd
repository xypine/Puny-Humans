extends ScrollContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var mouseOver = false
var allowGrab = false
var originalGrabPoint = Vector2(0,0)
var scrollMultiplier = 1
var lastGrab = Vector2(0,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var lastScrollX = 333
func _process(_delta):
	
	if Input.is_action_pressed("ui_scroll_up"):
		print("up")
	if Input.is_action_pressed("ui_scroll_down"):
		print("down")
	if mouseOver:
		$Helper2/TextureRect.self_modulate = Color(.15, .15, .15, 1)
	else:
		$Helper2/TextureRect.self_modulate = Color(.1, .1, .1, 1)
	if (Input.is_action_just_pressed("ui_grab") or InputExt.touchNow()) and mouseOver:
		originalGrabPoint = get_global_mouse_position()
		allowGrab = true
	if (Input.is_action_pressed("ui_grab") or InputExt.touch()) and allowGrab:
		lastGrab = (originalGrabPoint - get_global_mouse_position())*scrollMultiplier
		scroll_horizontal += lastGrab.x
		scroll_vertical += lastGrab.y
		originalGrabPoint = get_global_mouse_position()
	else:
		allowGrab = false
##	scroll += lastGrab
#	if scroll_horizontal != lastScrollX:
#		scroll_horizontal = scrollbarX.value
#	var scroll = scroll_horizontal #* scroll_max/100
#	lastScrollX = scroll_horizontal
#	scrollbar2.value = lastScroll2
func _on_Panel_mouse_entered():
	mouseOver = true
	print(mouseOver)


func _on_Panel_mouse_exited():
	mouseOver = false
	print(mouseOver)


func _on_TextureRect_mouse_entered():
	mouseOver = true


func _on_TextureRect_mouse_exited():
	mouseOver = false
