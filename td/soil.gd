#changed TileMapLayer to TileMap because it allowed map_to_world and cell_size
#let me know if this causes further errors
extends TileMap
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

func plant_seed_at(x: int, y: int) -> bool:
	# Attempt to plant a seed at (x, y)
	var index = _get_tile_index(x, y)
	if soil_states[index]:  # If tile is empty
		soil_states[index] = false  # Mark as full
		
		# Instantiate the Seed Scenes
		var seed_instance = rose_seed.instance() #figure what to put instead of "rose_scene" since there will be mulitple seed scenes
		get_parent().add_child(seed_instance) #adjust according to node structure
		# this is giving an error because of "extends TileMapLayer" ... the solution is to extend TileMap instead
		seed_instance.position = map_to_world(Vector2(x,y)) + Vector2(cell_size.x / 2, cell_size.y/ 2)
		
		#Attaching the AgeingComponent to the seed instance
		var ageing_component = AgeingComponent.new()
		seed_instance.add_child(ageing_component)
		ageing_component.target = seed_instance
		ageing_component.age_threshold = 0 #this needs to increment 
		# ageing_component.next_scene = #this is where the flower scenes goes in
		
		# connect the age_threshold_reached signal
		ageing_component.connect("age_threshold_reached", self, "_on_age_threshold_reached")
		
		return true  # Planting successful
	return false  # Tile is already full


func clear_tile(x: int, y: int):
	# Clear the soil at (x, y)
	var index = _get_tile_index(x, y)
	soil_states[index] = true  # Mark as empty

# Utility function to calculate the 1D index from 2D coordinates
func _get_tile_index(x: int, y: int) -> int:
	return y * get_used_rect().size.x + x
