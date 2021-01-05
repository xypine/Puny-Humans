extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = Vector2(0, 0)
export(float) var speed = 1.3
var isOnTarget = false
var idle = true

var damage = 50
var radius = 100

var charged = true

onready var anim = $AnimationPlayer
onready var recharge = $recharge

# Called when the node enters the scene tree for the first time.
func _ready():
	target = global_position

func toInt(vec):
	return Vector2(int(floor(vec.x*.5))*2, int(floor(vec.y*.5))*2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	isOnTarget = (global_position.distance_to(target) < 2 )
	if isOnTarget:
#		$Light2D.energy = .45
		pass
	else:
#		$Light2D.energy = .33
		
		var direction = target - global_position
		var vec = direction.normalized()
		var localspeed = (vec*speed + direction*0.01)
		global_position += localspeed
	var target = get_target()
	var notarget = false
	if str(target) != "":
		var dist = global_position.distance_to(target.global_position)
		if charged and dist < radius:
			attack(target)
		else:
			notarget = true
	else:
		notarget = true
	if notarget and isOnTarget:
		idle = true
func get_target():
	var ships = GameData.ships
	var closest = ""
	var closestDist = 99999999999
	for i in ships:
		var dist = global_position.distance_to(i.global_position)
		if dist < closestDist:
			closest = i
			closestDist = dist
	return closest
func attack(targetv):
	charged = false
	$AnimationPlayer.play("Attack")
	randomize()
	var rnd = rand_range(0, 101)
	if rnd < damage:
		targetv.attacker = self
		targetv.men -= 1
func gotKill(targetv):
#	idle = true
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		recharge.stop()
		recharge.start()


func _on_recharge_timeout():
	charged = true