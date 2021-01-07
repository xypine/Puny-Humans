extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var fullCont = $VBoxContainer
onready var mainCont = $VBoxContainer/Main
var oldSize = Vector2(0, 0)
var firstBoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Curtain.hide()
	GameData.isGameOn = false
	mainCont.current_tab = 2

onready var hud_money = $VBoxContainer/HUD/Money

var lastMoney = GameData.money
func updateHUD():
	if lastMoney != GameData.money:
		$Animations/Money.play("Money+")
	lastMoney = GameData.money
	hud_money.text = str(GameData.money) + "$"
	hud_money.margin_left = 8
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$VBoxContainer/Main/Settings/TitleSubControl/FScreenWarn.visible = not OS.is_window_fullscreen()
	$VBoxContainer/Main/Settings/TitleSubControl/FsystemWarn.visible = not OS.is_userfs_persistent()
	updateHUD()
	if Input.is_action_just_pressed("tab_next"):
		mainCont.current_tab += 1
	if Input.is_action_just_pressed("tab_prev"):
		mainCont.current_tab -= 1
	if mainCont.current_tab == 2 and firstBoot:
		$Animations/Transitions.play("FirstBoot")
		firstBoot = false
	GameData.isGameOn = (mainCont.current_tab == 2)
	
	mainCont.current_tab = min(3, mainCont.current_tab)
	mainCont.current_tab = max(1, mainCont.current_tab)
	mainCont.rect_size = (get_viewport().size * Vector2(1, .95))
	mainCont.rect_min_size = (get_viewport().size * Vector2(1, .95))
	fullCont.rect_size = get_viewport().size
	if mainCont.rect_size != oldSize:
		print(mainCont.rect_size)
		oldSize = mainCont.rect_size
	if Input.is_action_just_pressed("ui_accept"):
		print("Window size: " + str(get_viewport().size))
		print("Set size" + str(mainCont.rect_size))

