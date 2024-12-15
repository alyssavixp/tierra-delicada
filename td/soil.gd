extends TileMapLayer

@export var rose_seed: PackedScene
#@export var growth_scenes: Array = [
	#preload(""),  # First growth stage of the rose
#]

# Metadata for soil tiles
#var soil_states = []  # Array to track the states of each soil tile (true for empty, false for occupied)
#var growth_progress = {}  # Dictionary to track the growth stages for tiles, using tile positions as keys
var local_position  # Stores the position of the tile to interact with
var will_plant = false  # Flag indicating whether the player intends to plant a seed
var growth_timer: Timer = null #timer to manage growth progression

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
	# If the mouse is clicked, set the target position
	if event.is_action_pressed("click"):
		var mouse_position = get_global_mouse_position()
		local_position = to_local(mouse_position)
		var tile = get_cell_tile_data(local_to_map(local_position))
		if tile:
			will_plant = true
		else:
			will_plant = false
			prints(local_position, mouse_position)
	
#func _replace_tile_with_growth_scene(tile_pos: Vector2, stage: int):
	## Remove any existing plant instance and replace it with the new growth stage
	##var seed_instance = growth_scenes[stage].instantiate()
	#seed_instance.global_position = tile_pos #tile_to_map(tile_pos.x, tile_pos.y) + Vector2(16, 16)  # Center the instance
	#add_child(seed_instance)
#
	##if stage == growth_scenes.size() - 1:  # Final stage (harvestable)
		##print("flower at", tile_pos, "is ready for harvest!")
#
#func _on_player_destination_reached() -> void:
	#if will_plant:
		#_replace_tile_with_growth_scene(local_position, 0)
	#pass # Replace with function body.
	#
#func _advance_growth():
	## Advance the growth stage of all tiles every minute
	##for tile_pos in growth_progress.keys():
		#var _current_stage = growth_progress[tile_pos]  # Get the current growth stage of the tile
		#if _current_stage < growth_scenes.size() - 1:  # Check if growth can continue
			#_current_stage += 1  # Increment the growth stage
			#growth_progress[tile_pos] = _current_stage  # Update the growth stage in the dictionary
			#_replace_tile_with_growth_scene(tile_pos, _current_stage)  # Replace the tile with the new growth stage
