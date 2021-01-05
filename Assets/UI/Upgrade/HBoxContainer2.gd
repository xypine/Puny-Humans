extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var slider = $HSlider
onready var label = $Label
var reset = InputExt.mouseOffset.y
# Called when the node enters the scene tree for the first time.
func _ready():
	slider.value = reset


# Called every frame. 'delta' is the elapsed time since the previous frame.
var lastVal = reset
func _process(_delta):
	if InputExt.mouseOffset.y == lastVal:
		label.text = str(slider.value)
		InputExt.mouseOffset.y = slider.value
	else:
		slider.value = InputExt.mouseOffset.y
	lastVal = InputExt.mouseOffset.y


func _on_Button_pressed():
	slider.value = reset
