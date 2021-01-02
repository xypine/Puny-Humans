extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var mainCont = $Main

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animations/Transitions.play("FirstBoot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mainCont.rect_size = get_viewport().size

