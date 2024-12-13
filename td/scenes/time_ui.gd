extends Control

# References to the labels in the UI
@onready var days_label: Label = $DayControl/Days
@onready var hours_label: Label = $DayControl/ClockBG/ClockControl/Hours
@onready var minutes_label: Label = $DayControl/ClockBG/ClockControl/Minutes
@onready var seconds_label: Label = $DayControl/ClockBG/ClockControl/Seconds

func _ready():
	# Connect to the time_updated signal from the TimeSystem
	var time_system = $"../time_system"
	if time_system.connected("time_updated", self, "_on_time_updated"):
		print("Successfully connected to time_updated signal.")
	else:
		print("Failed to connect to time_updated signal.")

func _on_time_updated(date_time: Dictionary) : if date_time.has_all(["days", "hours", "minutes", "seconds"]): 
	update_label(days_label, date_time["days"], false)
	update_label(hours_label, date_time["hours"], true)
	update_label(minutes_label, date_time["minutes"], true)
	update_label(seconds_label, date_time["seconds"], true)

func add_leading_zero(value: int) -> String:
	# Returns the value as a string with a leading zero if needed
	return "0" + str(value) if value < 10 else str(value)

func update_label(label: Label, value: int, should_have_zero: bool = true) -> void:
	# Updates the label text with the formatted value
	label.text = add_leading_zero(value) if should_have_zero else str(value)
