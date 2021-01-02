tool
extends PanelContainer
class_name card_perk

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var CardName = "Priest-O-Gone"
export(String) var CardDesc = "Minions gain the ability to conjure ship priests."
export(int) var CardPrice= 300
export(String) var CPrice_currency = "$"
export(bool) var bought = false
export(bool) var needsPreviusBought = true

export(NodePath) var nextCard1
export(NodePath) var nextCard2

onready var l_cardName = $VBoxContainer/Card_Name
onready var l_cardDesc = $VBoxContainer/Stats
onready var l_cardPrice = $VBoxContainer/PriceContainer/Price
onready var btn_buy = $VBoxContainer/PriceContainer/Button

onready var line1 = $RelationshipLines/Line1
onready var line2 = $RelationshipLines/Line2
onready var receivingPos = $Receiving
onready var leavingPos = $RelationshipLines

var stop = false
var unlocked = true
var previus = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	updateInfo()
	if not Engine.editor_hint:
		updateLinePoints()

func updateInfo():
	l_cardName.text = str(CardName)
	l_cardDesc.text = str(CardDesc)
	l_cardPrice.text= str(CardPrice) + str(CPrice_currency)
	btn_buy.disabled = (not unlocked) or bought
	if bought:
		l_cardName.self_modulate = Color(.1, 1, .1, 1)
	else:
		l_cardName.self_modulate = Color(1, 1, 1, 1)
func updateLinePoints():
	var next1 = nextValid(nextCard1)
	if next1 and "receivingPos" in next1:
		next1.previus = self
		yield(next1, "ready")
		var p1 = Vector2(0, 0)
		var p2 = next1.receivingPos.global_position
		p2 = leavingPos.to_local(p2)
		line1.points = [p1, p2]
	else:
		line1.points = []
	var next2 = nextValid(nextCard2)
	if next2 and "receivingPos" in next2:
		next2.previus = self
		yield(next2, "ready")
		var p1 = Vector2(0, 0)
		var p2 = next2.receivingPos.global_position
		p2 = leavingPos.to_local(p2)
		line2.points = [p1, p2]
	else:
		line2.points = []
func updateUnlocked():
	if str(previus) != "" and is_instance_valid(previus):
		if previus.bought:
			unlocked = true
		else:
			unlocked = false
	elif needsPreviusBought:
		unlocked = false
	else:
		unlocked = true
func nextValid(next):
	if next == "":
		return false
	var nextI = get_node(next)
	if not is_instance_valid(nextI):
		return false
	return nextI
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.editor_hint:
		if not stop:
			updateUnlocked()
			updateInfo()
			updateLinePoints()
	else:
		updateUnlocked()
		updateInfo()
		updateLinePoints()
