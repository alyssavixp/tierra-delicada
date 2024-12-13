extends Node

@export var flower_count: int = 0  # Global flower count

@warning_ignore("unused_signal")
signal flower_count_changed(new_count: int)

func increment_flower_count(amount: int = 1):
	flower_count += amount
	emit_signal("flower_count_changed", flower_count)

func reset_flower_count():
	# Reset the flower count to 0
	flower_count = 0


func _on_ui_layer_ready() -> void:
	pass # Replace with function body.
