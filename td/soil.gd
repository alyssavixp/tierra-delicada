extends TileMapLayer
@export var rose_seed: PackedScene

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

func tile_to_world(tile_x: int, tile_y: int) -> Vector2:
	# Assuming 'cell_size' is the size of each tile
	var cell_size = Vector2(32, 32)  # Update this with your actual tile size
	return Vector2(tile_x * cell_size.x, tile_y * cell_size.y)


func plant_seed_at(x: int, y: int) -> bool:
	# Attempt to plant a seed at (x, y)
	var index = _get_tile_index(x, y)
	if soil_states[index]:  # If tile is empty
		soil_states[index] = false  # Mark as full
		_plant_seed_instance(x,y)
		return true # Planting successful
	return false # tile is already full

func _plant_seed_instance(x: int, y: int):
	var seed_instance = rose_seed.instance() #figure what to put instead of "rose_scene" since there will be mulitple seed scenes
	var seed_position = tile_to_world(x,y) + Vector2(32,32)
	seed_instance.global_position = seed_position
	add_child(seed_instance)
	get_parent().add_child(seed_instance)
	
	#Attaching the AgeingComponent to the seed instance
	var ageing_component = AgeingComponent.new()
	seed_instance.add_child(ageing_component)
	ageing_component.target = seed_instance
	ageing_component.connect("age_threshold_reached", "_on_age_threshold_reached", [Vector2(x, y)])

func _on_age_threshold_reached(new_scene: Node2D, tile_position: Vector2):
	# Assuming the new scene is the flower scene to be placed
	var flower_instance = new_scene
	var flower_position = tile_to_world(tile_position.x, tile_position.y) + Vector2(32, 32)  # Again assuming half the cell size
	flower_instance.global_position = flower_position
	add_child(flower_instance)
	
	# Update the tile's metadata to indicate it's no longer empty
	var index = _get_tile_index(int(tile_position.x), int(tile_position.y))
	soil_states[index] = false


func clear_tile(x: int, y: int):
	# Clear the soil at (x, y)
	var index = _get_tile_index(x, y)
	soil_states[index] = true  # Mark as empty

# Utility function to calculate the 1D index from 2D coordinates
func _get_tile_index(x: int, y: int) -> int:
	return y * get_used_rect().size.x + x
