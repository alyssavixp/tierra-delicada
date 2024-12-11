extends Node

@export var flower_count: int = 0  # Global flower count

func increment_flower_count(amount: int = 1):
	# Increment the flower count by the specified amount (default is 1)
	flower_count += amount

func reset_flower_count():
	# Reset the flower count to 0
	flower_count = 0
