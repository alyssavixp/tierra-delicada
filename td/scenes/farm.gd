extends Node

# References to specific nodes
@onready var player: CharacterBody2D = $Player  # Reference to the Player node in the scene
@onready var soil_layer: TileMapLayer = $soil  # Reference to the Soil layer in the scene
@onready var global_data: Node = $"global data"  # Reference to a global data node for shared information

func _ready():
	# Called when the node is added to the scene tree.
	if soil_layer != null:
		print("Soil layer connected successfully.")  # Debug message for soil layer connection
	else:
		print("Soil layer is missing.")  # Debug message if soil layer is not found

	if player != null:
		print("Player connected successfully.")  # Debug message for player connection
	else:
		print("Player is missing.")  # Debug message if player is not found

	if global_data != null:
		print("Global data connected successfully.")  # Debug message for global data connection
	else:
		print("Global data is missing.")  # Debug message if global data is not found
