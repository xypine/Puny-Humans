tool
extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var CardName = "Priest-O-Gone"
export var CardDesc = "Minions gain the ability to conjure ship priests."
export var CardPrice= 300
export var CPrice_currency = "$"

onready var l_cardName = $"VBoxContainer/Card Name"
onready var l_cardDesc = $VBoxContainer/Stats
onready var l_cardPrice= $VBoxContainer/PriceContainer/Price
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.editor_hint:
		l_cardName.text = str(CardName)
		l_cardDesc.text = str(CardDesc)
		l_cardPrice.text= str(CardPrice) + str(CPrice_currency)
