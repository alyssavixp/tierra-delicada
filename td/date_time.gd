class_name DateTime extends Resource

@export_range (0,59) var seconds: int = 0
@export_range (0,59) var minutes: int = 0
@export_range (0,23) var hours: int = 0
@export var days: int = 0

var delta_time: int= 0 

func increase_by_sec(delta_seconds: int) -> void:
	delta_time += delta_seconds
	if delta_time < 1: return
	
	seconds += delta_seconds
	@warning_ignore("integer_division")
	minutes += seconds / 60 
	@warning_ignore("integer_division")
	hours += minutes / 60
	@warning_ignore("integer_division")
	days += hours / 24
	
	seconds = seconds % 60
	minutes = minutes % 60 
	hours = hours % 24

	print_debug(str(days) + ":" + str(hours) + ":" + str(minutes) + ":" + str(seconds)) 
