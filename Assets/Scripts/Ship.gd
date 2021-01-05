extends Node2D
enum CellType { ShipSmall, ShipMedium, ShipBig }
export(CellType) var type = CellType.ShipSmall

onready var Grid = get_parent()

onready var healthbar = $Health
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var maxHealth = 100.0
export(float) var health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.max_value = maxHealth
	healthbar.value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthbar.value = health
func do_move(input_direction):
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		pass
		#bump()
func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)

