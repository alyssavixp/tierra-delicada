extends TileMapLayer

@export var rose_seed: PackedScene
@export var growth_scenes: Array = [
	preload("res://Objects/Farming Crops/rose_growth_1.tscn"),
	preload("res://Objects/Farming Crops/rose_growth_2.tscn"),
	preload("res://Objects/Farming Crops/rose_growth_3.tscn"),
	preload("res://Objects/Farming Crops/rose_growth_4.tscn"),
	preload("res://Objects/Farming Crops/rose_growth_harvest.tscn")
]
@onready var time_system = $"../TimeSystem"

# Metadata for soil tiles
var soil_states = []  # Use an array to store states (e.g., is_empty)
var growth_progress = {}  # Dictionary to track growth stages for tiles
var local_position 
var will_plant = false

func _ready():
	# Initialize soil states for each tile
	for x in range(0, get_used_rect().size.x):
		for y in range(0, get_used_rect().size.y):
			soil_states.append(true)  # All soil tiles start as empty
			growth_progress[Vector2(x, y)] = 0  # Initial growth stage for each tile

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

func _on_time_updated(_date_time: Dictionary):
	# Handle time updates to advance plant growth
	for tile_pos in growth_progress.keys():
		var _current_stage = growth_progress[tile_pos]
				# Replace the tile with the next growth scene
		_replace_tile_with_growth_scene(tile_pos, _current_stage)

## Check if the tile has a plant and advance its growth
		#if !soil_states[_get_tile_index(tile_pos, _current_stage)] and _current_stage < growth_scenes.size() - 1:
			## For simplicity, advance one stage every hour
			#if _date_time["hours"] % 1 == 0:  # Adjust growth frequency as needed
				#_current_stage += 1
				#growth_progress[tile_pos] = _current_stage

func _on_time_system_time_updated(_date_time: Dictionary) -> void:
	pass 
	
func _replace_tile_with_growth_scene(tile_pos: Vector2, stage: int):
	# Remove any existing plant instance and replace it with the new growth stage
	var seed_instance = growth_scenes[stage].instantiate()
	seed_instance.global_position = tile_pos #tile_to_map(tile_pos.x, tile_pos.y) + Vector2(16, 16)  # Center the instance
	add_child(seed_instance)

	if stage == growth_scenes.size() - 1:  # Final stage (harvestable)
		print("flower at", tile_pos, "is ready for harvest!")


func _on_player_destination_reached() -> void:
	if will_plant:
		_replace_tile_with_growth_scene(local_position, 0)
	pass # Replace with function body.
