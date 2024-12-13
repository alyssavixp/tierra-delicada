extends CanvasLayer

# Reference to the Global_Data node
@onready var global_data: Node = $"global data"

# Reference to the Label node
@onready var flower_count_label: Label = $"Player/UI Layer/Flower_Count_Label"

#func _ready():
	#if global_data:
		##global_data.connect("flower_count_changed", self, "_update_flower_count")
	#else:
		#print("Error: Global_Data node not found.")

func _update_flower_count(new_count: int):
	flower_count_label.text = "Flowers: " + str(new_count)

func _process(_delta):
	## Safeguard to ensure global_data is valid
	if global_data:
		## Update the label to reflect the current flower count
		flower_count_label.text = "Flowers Collected: " + str(global_data.flower_count)
	else:
		print("Error: Global_Data node not found!")


func _on_global_data_flower_count_changed(_new_count: int) -> void:
	pass # Replace with function body.


func _on_global_data_ready() -> void:
	pass # Replace with function body.
