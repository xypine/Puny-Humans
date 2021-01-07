extends Node2D
enum CellType { ShipSmall, ShipMedium, ShipBig }
export(CellType) var type = CellType.ShipSmall

onready var Grid = get_parent()

onready var healthbar = $Textures/Health
onready var light = $Textures/Light2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var maxMen = 20.0
export(float) var men = 20.0
export(float) var priestPercent = 10
export(int) var value = 75
var priests = (men*0.01)*priestPercent
var textures = []

var targetPos = Vector2(0, 0)
var lightm = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	priests = (men*0.01)*priestPercent
#	print(priests)
	healthbar.max_value = maxMen
	healthbar.value = men
	for i in $Textures/T/.get_children():
		if not (i in [healthbar, light]):
			textures.append(i)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var dead = false
var frame = 0
func _process(_delta):
	if str(lightm) != "":
		lightm.position = global_position
	targetPos = global_position + $Textures.position
	if dead:
		return
	var move = Vector2(0, 0)
	if global_position.y < 0:
		pass
	else:
		healthbar.value = men
		healthbar.rect_min_size.x = (26 + (men-20)*2)
		if str(attacker) != "" and frame % 100 == 0:
			var dir = evade()
			move += dir
		if str(attacker) != "" and frame % 90 == 0:
			randomize()
			var chance = (randi() % 2 == 0)
			if chance and priests > 0:
				attack(attacker)
		if men < 1:
			dead = true
			var ind = GameData.ships.find(self)
			GameData.ships.remove(ind)
			GameData.money += value
			$AnimationPlayer.play("Die")
			attacker.gotKill(self)
	
	if frame % 200 == 0:
		move += Vector2(0, 1)
	if move != Vector2(0, 0):
		update_look_direction(move)
		do_move(move)
	frame += 1
func attack(attackr):
	$AnimationPlayer.play("Attack")
	attackr.health -= 5*priests
func do_move(input_direction):
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position, input_direction)
	else:
		pass
		#bump()
func move_to(target_position, dir):
	set_process(false)
#	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
#	var move_direction = (target_position - position).normalized()
#	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	play_move(dir)
	yield($Move, "animation_finished")
	$Textures/T.modulate = Color(1,1,1,0.5)
	position = target_position
	$Textures.position = Vector2(0, 0)
	$Textures/T.modulate = Color(1,1,1,1)

#	$Tween.start()

	# Stop the function execution until the animation finished
#	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)
func play_move(dir):
	match str(dir.x) + "," + str(dir.y):
		"0,1":
			$Move.play("01")
		"1,1":
			$Move.play("11")
		"-1,1":
			$Move.play("-11")
		"1,0":
			$Move.play("10")
		"-1,0":
			$Move.play("-10")
func update_look_direction(direction):
	for i in textures:
		i.visible = false
	match str(direction.angle()):
		"1.570796":
			$Textures/T/F2.visible = true
		"0.785398":
			$Textures/T/F3.visible = true
		"0":
			$Textures/T/F4.visible = true
		"-0.785398":
			$Textures/T/F5.visible = true
		"-1.570796":
			$Textures/T/F6.visible = true
		"-2.356194":
			$Textures/T/F7.visible = true
		"3.141593":
			$Textures/T/F0.visible = true
		"2.356194":
			$Textures/T/F1.visible = true

var attacker = ""

func evade():
	randomize()
	var dir = (randi() % 2 == 0)
	if dir:
		return(Vector2(1, 0))
	return(Vector2(-1, 0))

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Die":
		if str(lightm) != "":
			lightm.queue_free()
		Grid.set_cellv(Grid.world_to_map(position), -1)
		print("Ship shunk at " + str(Grid.world_to_map(position)))
		queue_free()
