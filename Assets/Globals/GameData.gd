extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isGameOn = true

var money = 0

var ships = []
var BuffSpeed = 1
var BuffAttack= 0
var BuffPriests=0
var BuffRange = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	loadConfig()

var configFile = "user://config.json"
func saveConfig():
	var data = {}
	data["mouseOffset"] = var2str(InputExt.mouseOffset)
	
	var file = File.new()
	file.open(configFile, File.WRITE)
	file.store_line(to_json(data))
	file.close()
func loadConfig():
	var file = File.new()
	if file.file_exists(configFile):
		file.open(configFile, File.READ)
		var data = {}
		var text = file.get_as_text()
		data = parse_json(text)
		
		InputExt.mouseOffset = str2var(data["mouseOffset"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
