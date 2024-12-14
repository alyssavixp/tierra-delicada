extends TileMapLayer

@export var rose_seed: PackedScene
@export var growth_scenes: Array = [
	preload("res://aging_objects/Farming Crops/rose_growth_1.tscn"),  # First growth stage of the rose
	preload("res://aging_objects/Farming Crops/rose_growth_2.tscn"),  # Second growth stage of the rose
	preload("res://aging_objects/Farming Crops/rose_growth_3.tscn"),  # Third growth stage of the rose
	preload("res://aging_objects/Farming Crops/rose_growth_4.tscn"),  # Fourth growth stage of the rose
	preload("res://aging_objects/Farming Crops/rose_growth_harvest.tscn")  # Final harvestable stage of the rose
]

# Metadata for soil tiles
var soil_states = []  # Array to track the states of each soil tile (true for empty, false for occupied)
var growth_progress = {}  # Dictionary to track the growth stages for tiles, using tile positions as keys
var local_position  # Stores the position of the tile to interact with
var will_plant = false  # Flag indicating whether the player intends to plant a seed
var growth_timer: Timer = null #timer to manage growth progression

func _ready():
	# Initialize soil states for each tile
	for x in range(0, get_used_rect().size.x):  # Loop through the x-coordinates of the TileMap
		for y in range(0, get_used_rect().size.y):  # Loop through the y-coordinates of the TileMap
			soil_states.append(true)  # Mark each tile as empty at the start
			growth_progress[Vector2(x, y)] = 0  # Set the initial growth stage for each tile to 0

	# Start a timer to manage growth progression every minute
	growth_timer = Timer.new()  # Create a new Timer instance
	growth_timer.wait_time = 60  # Set timer to 60 seconds (1 minute)
	growth_timer.one_shot = false  # Repeat the timer
	growth_timer.connect("timeout", Callable(self, "_advance_growth"))  # Corrected connection to the growth function
	add_child(growth_timer)
	growth_timer.start()  # Start the timer
		
func _input(event):
	# Handle mouse input for planting seeds
	if event.is_action_pressed("click"):
		var mouse_position = get_global_mouse_position()  # Get the global mouse position
		local_position = to_local(mouse_position)  # Convert the global position to local tile coordinates
		var tile = get_cell_tile_data(local_to_map(local_position))  # Get tile data for the clicked position
		if tile:
			will_plant = true  # Set the flag to indicate planting is possible
		else:
			will_plant = false  # Clear the planting flag
			prints(local_position, mouse_position)  # Debug output for tile positions
	
func _replace_tile_with_growth_scene(tile_pos: Vector2, stage: int):
	# Replace the tile with the corresponding growth stage scene
	#Remove any existing instance at the tile position
	var existing_instance = null
	for child in get_children():
		if child.global_position == tile_pos:
			existing_instance = child
			break
	if existing_instance:
		existing_instance.queue_free()  # Free the previous instance
	var seed_instance = growth_scenes[stage].instantiate()  # Instantiate the scene for the given growth stage
	seed_instance.global_position = tile_pos  # Set the position of the new instance to match the tile
	add_child(seed_instance)  # Add the instance to the scene tree

	if stage == growth_scenes.size() - 1:  # Check if this is the final harvestable stage
		print("flower at", tile_pos, "is ready for harvest!")  # Output a message for the harvestable flower

func _on_player_destination_reached() -> void:
	# Handle the event when the player reaches the destination
	if will_plant:
		_replace_tile_with_growth_scene(local_position, 0)  # Replace the tile with the initial growth stage
	pass # Placeholder for additional functionality
	
func _advance_growth():
	# Advance the growth stage of all tiles every minute
	for tile_pos in growth_progress.keys():
		var _current_stage = growth_progress[tile_pos]  # Get the current growth stage of the tile
		if _current_stage < growth_scenes.size() - 1:  # Check if growth can continue
			_current_stage += 1  # Increment the growth stage
			growth_progress[tile_pos] = _current_stage  # Update the growth stage in the dictionary
			_replace_tile_with_growth_scene(tile_pos, _current_stage)  # Replace the tile with the new growth stage

		# Link the updated growth stage to the corresponding scene from growth_scenes
		var updated_scene = growth_scenes[_current_stage]  # Get the scene corresponding to the new growth stage
		print("Tile at", tile_pos, "advanced to stage", _current_stage, "linked to scene:", updated_scene)
