extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var t = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += 1
	if t % 100 == 0:
		texture.noise.seed += 1
