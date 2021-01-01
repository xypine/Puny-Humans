extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scrollHelper = $Panel/Helper
onready var scrollbar = $HScrollBar

var scroll_max = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scroll = scrollbar.value * scroll_max/100
	scrollHelper.anchor_left = -scroll
func scroll(val):
	pass
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# scroll r
			if event.button_index == BUTTON_WHEEL_UP:
				scrollbar.value += 1
				print(scrollbar.value)
			# scroll l
			if event.button_index == BUTTON_WHEEL_DOWN:
				scrollbar.value -= 1
var mouseOver = false

func _on_Panel_mouse_entered():
	mouseOver = true


func _on_Panel_mouse_exited():
	mouseOver = true
