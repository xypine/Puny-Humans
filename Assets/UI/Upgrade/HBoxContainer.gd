extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var slider = $HSlider
onready var label = $Label
var reset = InputExt.mouseOffset.x
# Called when the node enters the scene tree for the first time.
func _ready():
	slider.value = reset


# Called every frame. 'delta' is the elapsed time since the previous frame.
var lastVal = reset
func _process(_delta):
	if InputExt.mouseOffset.x == lastVal:
		label.text = str(slider.value)
		InputExt.mouseOffset.x = slider.value
	else:
		slider.value = InputExt.mouseOffset.x
	lastVal = InputExt.mouseOffset.x


func _on_Button_pressed():
	slider.value = reset
