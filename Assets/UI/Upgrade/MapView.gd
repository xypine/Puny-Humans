extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scrollHelper = $Panel/Helper
onready var scrollbar = $HScrollBar
onready var scrollbar2 = $HScrollBar2

var scroll_max = .6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var originalGrabPoint = Vector2(0, 0)
var lastGrab = 0
var totalGrab = 0
var allowGrab = false

var lastScroll2 = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_pressed("ui_scroll_up"):
		print("up")
	if Input.is_action_pressed("ui_scroll_down"):
		print("down")
	if mouseOver:
		$Panel/Helper/TextureRect.self_modulate = Color(.15, .15, .15, 1)
	else:
		$Panel/Helper/TextureRect.self_modulate = Color(.1, .1, .1, 1)
	if (Input.is_action_just_pressed("ui_grab") or InputExt.touchNow()) and mouseOver:
		originalGrabPoint = get_global_mouse_position()
		allowGrab = true
	if (Input.is_action_pressed("ui_grab") or InputExt.touch()) and allowGrab:
		lastGrab = (originalGrabPoint.x - get_global_mouse_position().x)/4
		scrollbar.value += lastGrab
		originalGrabPoint = get_global_mouse_position()
	else:
		allowGrab = false
#	scroll += lastGrab
	if scrollbar2.value != lastScroll2:
		scrollbar.value = scrollbar2.value
	var scroll = scrollbar.value * scroll_max/100
	lastScroll2 = scrollbar.value
	scrollbar2.value = lastScroll2
	
	scrollHelper.anchor_left = -scroll
#func scroll(val):
#	pass
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# scroll r
			if event.button_index == BUTTON_WHEEL_UP:
				scrollbar.value += 1.5
#				print(scrollbar.value)
			# scroll l
			if event.button_index == BUTTON_WHEEL_DOWN:
				scrollbar.value -= 1.5
#				print(scrollbar.value)
var mouseOver = false

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
