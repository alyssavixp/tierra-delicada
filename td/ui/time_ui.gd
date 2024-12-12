extends Control

@onready var days_label: Label = $DayControl/days
@onready var hours_label: Label = $DayControl/ClockBG/ClockControl/hours
@onready var minutes_label: Label = $DayControl/ClockBG/ClockControl/minutes
@onready var seconds_label: Label = $DayControl/ClockBG/ClockControl/seconds

func _ready():
	# Connect to the time_updated signal
	var time_system = $"../TimeSystem"
	#time_system.connect("time_updated", Callable, "_on_time_updated")

#func _on_time_updated(date_time: Dictionary):
	## Update the UI with the current date and time
	#days_label.text = str(date_time["days"])
	#hours_label.text = str(date_time["hours"]).pad_left(2, "0")
	#minutes_label.text = str(date_time["minutes"]).pad_left(2, "0")
	#seconds_label.text = str(date_time["seconds"]).pad_left(2, "0")

func add_leading_zero(value: int) -> String:
	# Returns the value as a string with a leading zero if needed
	if value < 10:
		return "0" + str(value)
	return str(value)

func update_label(label: Label, value: int, should_have_zero: bool = true) -> void:
	# Updates the label text with the formatted value
	label.text = add_leading_zero(value) if should_have_zero else str(value)
