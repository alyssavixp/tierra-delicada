extends TileMapLayer

# Metadata for soil tiles
var soil_states = []  # Use an array to store states (e.g., is_empty)

func _ready():
	# Initialize soil states for each tile
	for x in range(0, get_used_rect().size.x):
		for y in range(0, get_used_rect().size.y):
			soil_states.append(true)  # All soil tiles start as empty

func is_tile_empty(x: int, y: int) -> bool:
	# Check if a tile at (x, y) is empty
	var index = _get_tile_index(x, y)
	return soil_states[index]

func plant_seed_at(x: int, y: int) -> bool:
	# Attempt to plant a seed at (x, y)
	var index = _get_tile_index(x, y)
	if soil_states[index]:  # If tile is empty
		soil_states[index] = false  # Mark as full
		return true  # Planting successful
	return false  # Tile is already full

func clear_tile(x: int, y: int):
	# Clear the soil at (x, y)
	var index = _get_tile_index(x, y)
	soil_states[index] = true  # Mark as empty

# Utility function to calculate the 1D index from 2D coordinates
func _get_tile_index(x: int, y: int) -> int:
	return y * get_used_rect().size.x + x
