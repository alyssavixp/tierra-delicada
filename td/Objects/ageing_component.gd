extends Node
class_name AgeingComponent

## Track object age and can replace target scene
## with a new scene after reaching an age_threshold

@warning_ignore("unused_signal")
signal age_changed(new_age: float, last_age: float)
@warning_ignore("unused_signal")
signal age_threshold_reached(new_scene, seed_instance, tile_position)

## Preloaded growth scenes
@export var growth_scenes: Array = []
@export var age_thresholds: Array = [5.0, 10.0, 15.0, 20.0, 25.0]  # Corresponding thresholds for growth stages
@export var target_tile_position: Vector2 = Vector2.ZERO  # Tile position in the soil layer

@export var target: Node2D
@export var current_age: float = 0.0:
	set(value):
		if current_age != value:
			var last_age = current_age
			current_age = value
			emit_signal("age_changed", current_age, last_age)
			
			if current_stage < growth_scenes.size() and current_age >= age_thresholds[current_stage]:
				_transition_to_next_stage()
			elif current_stage == growth_scenes.size():
				_threshold_reached = true
				emit_signal("age_threshold_reached", growth_scenes[current_stage - 1], self, target_tile_position)

const group_name = "AgeingComponent"
var current_stage: int = 0
var _threshold_reached: bool = false

func _ready():
	if target == null:
		target = get_parent()
	if growth_scenes.size() != age_thresholds.size():
		print("Error: growth_scenes and age_thresholds must have the same length!")
		return
	_transition_to_stage(current_stage)

func _transition_to_next_stage():
	current_stage += 1
	if current_stage < growth_scenes.size():
		_transition_to_stage(current_stage)

func _transition_to_stage(stage: int):
	var instance = growth_scenes[stage].instantiate()
	#instance.position = position
	get_parent().add_child(instance)
	queue_free()


func _on_soil_changed() -> void:
	pass # Replace with function body.
