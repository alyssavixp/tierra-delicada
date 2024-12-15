extends TileMapLayer

@export var rose_seed: PackedScene
#@export var growth_scenes: Array = [
	#preload(""),  # First growth stage of the tulip
#]

# Metadata for soil tiles
#var soil_states = []  # Array to track the states of each soil tile (true for empty, false for occupied)
#var growth_progress = {}  # Dictionary to track the growth stages for tiles, using tile positions as keys
var local_position  # Stores the position of the tile to interact with
var will_plant = false  # Flag indicating whether the player intends to plant a seed
#var growth_timer: Timer = null #timer to manage growth progression

#func _ready():
	# Initialize soil states for each tile
	#for x in range(0, get_used_rect().size.x):
		#for y in range(0, get_used_rect().size.y):
			#soil_states.append(true)  # All soil tiles start as empty
			#growth_progress[Vector2(x, y)] = 0  # Initial growth stage for each tile

	## Start a timer to manage growth progression every minute
	#growth_timer = Timer.new()  # Create a new Timer instance
	#growth_timer.wait_time = 60  # Set timer to 60 seconds (1 minute)
	#growth_timer.one_shot = false  # Repeat the timer
	#growth_timer.connect("timeout", Callable(self, "_advance_growth"))  # Corrected connection to the growth function
	#add_child(growth_timer)
	#growth_timer.start()  # Start the timer
		
func _input(event):
	# Mouse input to determine where the player is interacting
	if event.is_action_pressed("click"):
		var mouse_position = get_global_mouse_position()
		local_position = to_local(mouse_position) #converting global to local relative to the TileMapLayer
		var tile = get_cell_tile_data(local_to_map(local_position)) #Retrieve the tile data at the clicked position.
		if tile:
			will_plant = true #set flag to true if clicked position is valid
		else:
			will_plant = false
			prints(local_position, mouse_position) #debugging output to display clicked positions
	
# Placeholder function: Called when the player reaches the destination.
# This is commented out for now but can be used for future implementation.
# func _on_player_destination_reached() -> void:
# 	if will_plant:
# 		_replace_tile_with_growth_scene(local_position, 0)  # Placeholder for seed planting logic.
# 	pass  # Placeholder body to be replaced with functionality.

# Interaction Area Proposal:
# Instead of using a timer or built-in TileMap functionality, I will implement an Area2D node.
# The Area2D will serve as a generic 'interaction area' that detects if the player enters its region.
# The idea is to allow specific nodes (e.g., soil, plants) to check whether the player is in an interaction area
# and decide what to do differently based on that condition.
