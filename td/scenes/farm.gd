extends Node2D

# References to essential nodes
onready var soil_layer: TileMapLayer = $soil  # Soil for interactions
#onready var global_data: Node = $global_data  # Reference to global data node
onready var player: Node = $player  # Player instance

func _ready():
	print("Farm scene initialized.")
	_test_player_soil_interaction()

# Test player interaction with soil (for debugging)
func _test_player_soil_interaction():
	var player_position = player.global_position
	var cell_coords = soil_layer.world_to_map(player_position)

	if soil_layer.has_cell(cell_coords):
		if soil_layer.get_meta(cell_coords, "is_empty", true):
			print("Player is over empty soil at:", cell_coords)
		else:
			print("Player is over full soil at:", cell_coords)
	else:
		print("Player is not on valid soil.")
