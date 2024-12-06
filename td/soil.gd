extends TileMapLayer

# State to track if the soil is empty or has a seed planted
var is_empty: bool = true  # The soil starts empty by default

# Function to plant a seed on the soil
func plant_seed(seed_scene: PackedScene) -> bool:
	if is_empty:
		# Instantiate the seed scene
		var seed_instance = seed_scene.instantiate()
		add_child(seed_instance)

		# Align the seed to the center of the soil
		seed_instance.position = Vector2.ZERO  # Adjust if soil isn't at (0, 0)
		
		# Set the soil to full
		is_empty = false
		return true  # Planting successful
	else:
		return false  # Soil is already full

# Function to clear the soil (optional, e.g., for harvesting)
func clear_soil():
	for child in get_children():
		if child != self:
			child.queue_free()
	is_empty = true  # Reset the soil to empty
