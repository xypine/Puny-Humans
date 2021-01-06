extends TileMap

enum CellType { EMPTY = -1, ShipSmall, ShipMedium, ShipBig }

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.ships = []
	for child in get_children():
		GameData.ships.append(child)
		set_cellv(world_to_map(child.position), child.type)
#		child.position = map_to_world(world_to_map(child.position)) + Vector2(32, 32)

func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	if(get_cell_pawn(cell_target) != pawn):
		print(cell_target_type)
		match cell_target_type:
			CellType.EMPTY:
				return update_pawn_position(pawn, cell_start, cell_target)

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, CellType.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
