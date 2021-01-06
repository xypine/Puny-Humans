extends Node2D
enum CellType { ShipSmall, ShipMedium, ShipBig }
export(CellType) var type = CellType.ShipSmall

onready var Grid = get_parent()

onready var healthbar = $Health
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var maxMen = 20.0
export(float) var men = 20.0
export(float) var priestPercent = 10
export(int) var value = 75
var priests = (men*0.01)*priestPercent
var textures = []

# Called when the node enters the scene tree for the first time.
func _ready():
	priests = (men*0.01)*priestPercent
	healthbar.max_value = maxMen
	healthbar.value = men
	for i in $Textures.get_children():
		textures.append(i)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var dead = false
var frame = 0
func _process(delta):
	if dead:
		return
	healthbar.value = men
	var move = Vector2(0, 0)
	if str(attacker) != "" and frame % 100 == 0:
		var dir = evade()
		move += dir
	if str(attacker) != "" and frame % 90 == 0:
		randomize()
		var chance = (randi() % 2 == 0)
		if chance:
			attack(attacker)
	if frame % 200 == 0:
		move += Vector2(0, 1)
	if move != Vector2(0, 0):
		update_look_direction(move)
		do_move(move)
	if men < 1:
		dead = true
		var ind = GameData.ships.find(self)
		GameData.ships.remove(ind)
		GameData.money += value
		$AnimationPlayer.play("Die")
		attacker.gotKill(self)
	frame += 1
func attack(attackr):
	$AnimationPlayer.play("Attack")
	attackr.health -= 5*priests
func do_move(input_direction):
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		pass
		#bump()
func move_to(target_position):
	set_process(false)
#	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
#	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

#	$Tween.start()

	# Stop the function execution until the animation finished
#	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)
func update_look_direction(direction):
	print("---")
	print(Vector2(0, 1).angle())
	print(Vector2(1, 1).angle())
	print(Vector2(1, 0).angle())
	print(Vector2(1, -1).angle())
	print(Vector2(0, -1).angle())
	print(Vector2(-1, -1).angle())
	print(Vector2(-1, 0).angle())
	print(Vector2(-1, 1).angle())
	print()
	print(direction.angle())
	print(direction)
	print("...")
	for i in textures:
		i.visible = false
	match str(direction.angle()):
		"1.570796":
			$Textures/F2.visible = true
		"0.785398":
			$Textures/F3.visible = true
		"0":
			$Textures/F4.visible = true
		"-0.785398":
			$Textures/F5.visible = true
		"-1.570796":
			$Textures/F6.visible = true
		"-2.356194":
			$Textures/F7.visible = true
		"3.141593":
			$Textures/F0.visible = true
		"2.356194":
			$Textures/F1.visible = true

var attacker = ""

func evade():
	randomize()
	var dir = (randi() % 2 == 0)
	if dir:
		return(Vector2(1, 0))
	return(Vector2(-1, 0))

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Die":
		queue_free()
