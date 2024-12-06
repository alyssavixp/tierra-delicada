extends Node2D

# Reference to the rose_seed scene (must be assigned in the Inspector)
@export var seed_scene: PackedScene = null # Explicitly initialize to null
  # This is the scene that will be planted (e.g., rose_seed)

# Reference to the soil TileMapLayer
onready var soil_layer: TileMap = $soil  # Adjust this path if necessary to match your scene's hierarchy

func _ready():
	# Called when the farm scene is ready
	# Ensures that required components like the seed scene and soil layer are properly initialized
	if seed_scene == null:
		print("Error: seed_scene is not assigned!")  # Error message if no seed scene is assigned
	else:
		print("Farm initialized with seed_scene:", seed_scene)  # Confirm that the seed scene is set

# Function to plant a seed at a specific world position
func plant_seed_at(world_position: Vector2):
	# Plants a seed at the given world position if the tile at that position is valid soil and is empty

	# Convert the world position to the corresponding tile coordinates in the TileMap
	var cell_coords = soil_layer.world_to_map(world_position)

	# Check if there's valid soil at this tile position
	if soil_layer.get_cellv(cell_coords) != null:  # Ensure there's a tile at this position
		# Fetch the soil instance at this position
		# In this case, soil instances should be set up to track their state (e.g., is_empty)
		var soil_instance = soil_layer.get_node_at_position(world_position)  # Replace with your custom logic
		if soil_instance and soil_instance.is_empty:  # If the soil is empty
			# Create an instance of the seed scene
			var seed_instance = seed_scene.instantiate()
			
			# Add the seed to the soil TileMap
			soil_layer.add_child(seed_instance)
			
			# Align the seed's position to the center of the target soil tile
			seed_instance.position = soil_layer.map_to_world(cell_coords) + soil_layer.cell_size / 2
			
			# Mark the soil as full
			soil_instance.is_empty = false
			print("Seed planted at:", world_position)  # Log success
		else:
			print("Cannot plant seed: Soil is already full.")  # Log failure if soil is full
	else:
		print("Cannot plant seed: No valid soil at this position.")  # Log failure if no soil exists

# Example usage: Call this when the player interacts with the soil
func _process(delta):
	# Continuously checks for player input (e.g., planting seeds) and handles interaction with the soil

	# Replace this with your player's actual global position
	var player_position = $player.global_position  # Example: Adjust path to your player node

	# Check for the "plant_seed" action (you must configure this in Input Map)
	if Input.is_action_just_pressed("plant_seed"):  # Replace with your desired action
		plant_seed_at(player_position)  # Call planting function with the player's position
