extends TileMap

enum CellType { EMPTY = -1, ShipSmall, ShipMedium, ShipBig }

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.ships = []
	for child in get_children():
		var light = $"../ShipMini/Light2D".duplicate()
		light.position = child.global_position
		$"../ShipMini".add_child(light)
		child.lightm = light
		GameData.ships.append(child)
		set_cellv(world_to_map(child.position), child.type)
#		child.position = map_to_world(world_to_map(child.position)) + Vector2(32, 32)
	var light = $"../ShipMini/Light2D"
	light.queue_free()
var frame = 0
func _process(_delta):
	if frame % 200 == 0:
		pass
#		$"../ShipMini".position.y += 1
	frame += 1
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	if(get_cell_pawn(cell_target) != pawn):
#		print(cell_target_type)
		match cell_target_type:
			CellType.EMPTY:
				return update_pawn_position(pawn, cell_start, cell_target)

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, CellType.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
