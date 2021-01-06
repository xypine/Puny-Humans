extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label = $Label2
onready var bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	label.text = str(GameData.BuffAttack*100) + "%"
	bar.value = GameData.BuffAttack
