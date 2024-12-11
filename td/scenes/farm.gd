extends Node

# References to specific TileMapLayers
@onready var player: CharacterBody2D = $Player  # Reference the Player node
@onready var soil_layer: TileMapLayer = $soil # Will dynamically find the Soil TileMapLayer using groups

func _ready():
	# Find the Soil TileMapLayer using a group
	var soil_nodes = get_tree().get_nodes_in_group("SoilLayer")
	if soil_nodes.size() > 0:
		soil_layer = soil_nodes[0]  # Get the first node in the SoilLayer group
		print("Soil layer found:", soil_layer)
	else:
		print("Error: No soil layer found in the 'SoilLayer' group.")
		return  # Exit if no Soil layer is found

	print("Farm scene initialized.")
	_test_player_soil_interaction()  # Call the test function for debugging

# Test player interaction with the Soil TileMapLayer
func _test_player_soil_interaction():
	# Ensure soil_layer is initialized
	if soil_layer == null:
		print("Error: Soil layer is not set.")
		return

	# Ensure player is initialized
	if player == null:
		print("Error: Player is not set.")
		return

	# Get the player's current global position
	var player_x = player.global_position.x
	var player_y = player.global_position.y

	# Convert the player's position to tile coordinates in the Soil TileMapLayer
	var cell_size_x = soil_layer.cell_size.x
	var cell_size_y = soil_layer.cell_size.y
	var _tile_x = int(floor(player_x / cell_size_x))
	var _tile_y = int(floor(player_y / cell_size_y))
