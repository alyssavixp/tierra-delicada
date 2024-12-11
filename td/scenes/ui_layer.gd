extends CanvasLayer

# Reference to the Global_Data node
@onready var global_data: Node = $"../global_data"

# Reference to the Label node
@onready var flower_count_label: Label = $Flower_Count_Label

func _process(delta):
	# Safeguard to ensure global_data is valid
	if global_data:
		# Update the label to reflect the current flower count
		flower_count_label.text = "Flowers Collected: " + str(global_data.flower_count)
	else:
		print("Error: Global_Data node not found!")
