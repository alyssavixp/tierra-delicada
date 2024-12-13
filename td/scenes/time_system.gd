extends Node

# Signal to notify other systems of time updates
@warning_ignore("unused_signal")
signal time_updated(date_time: Dictionary)

# Time-tracking variables
var date_time = {
	"days": 0,
	"hours": 6,   # Start at 6 AM
	"minutes": 0,
	"seconds": 0
}

@export var time_speed: float = 60.0  # Number of in-game seconds per real second

func _ready():
	# Start updating time
	set_process(true)

func emit_time_updated_signal(): emit_signal("time_updated", date_time)

func _process(delta: float):
	# Update time based on delta and time_speed
	date_time["seconds"] += delta * time_speed
	if date_time["seconds"] >= 60:
		date_time["seconds"] = 0
		date_time["minutes"] += 1
	if date_time["minutes"] >= 60:
		date_time["minutes"] = 0
		date_time["hours"] += 1
	if date_time["hours"] >= 24:
		date_time["hours"] = 0
		date_time["days"] += 1

	# Emit time_updated signal
	emit_signal("time_updated", date_time)
