extends ScrollContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var mouseOver = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_pressed("ui_scroll_up"):
		print("up")
	if Input.is_action_pressed("ui_scroll_down"):
		print("down")
	if mouseOver:
		$Helper2/TextureRect.self_modulate = Color(.15, .15, .15, 1)
	else:
		$Helper2/TextureRect.self_modulate = Color(.1, .1, .1, 1)

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
