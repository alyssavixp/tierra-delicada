extends Node

# References to specific nodes
@onready var player: CharacterBody2D = $Player
@onready var soil_layer: TileMapLayer = $soil
@onready var global_data: Node = $Global_Data
@onready var time_system: Node = $time_system
@onready var ui_layer: CanvasLayer = $CanvasLayer

func _ready():
	# Connect the signal from the TimeSystem to this script
	if time_system:
		var connected = time_system.connected("time_updated", self, "_on_time_updated")
		if connected:
			print("Successfully connected to time_updated signal.")
		else:
			print("Failed to connect to time_updated signal.")
	else:
		print("Error: TimeSystem node not found.")
		
	print("Farm scene initialized.")

func _on_time_updated(date_time: Dictionary):
	# Handle the time update here
	print("Time updated:", date_time)
	# Call a function to update soil growth
	soil_layer.update_growth(date_time)
	ui_layer.update_ui(date_time)

	# Find the Soil TileMapLayer using a group
	var soil_nodes = get_tree().get_nodes_in_group("soil")
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
		
		
