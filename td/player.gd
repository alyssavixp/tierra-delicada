extends CharacterBody2D

@export var speed: float = 300  # Movement speed of the player

# Target position as separate x and y components
var target_x: float = 0
var target_y: float = 0
signal destination_reached
@onready var body: AnimatedSprite2D = $body  # Reference to the main body AnimatedSprite2D
@onready var body_parts: Array = [
	$body/overalls,
	$body/overalls/pants,
	$body/overalls/pants/shoes,
	$body/overalls/pants/shoes/blush,
	$body/overalls/pants/shoes/blush/eyes,
	$body/overalls/pants/shoes/blush/eyes/hair,
	$body/overalls/pants/shoes/blush/eyes/hair/hat
]  # Explicitly reference each part under 'body'

var is_walking: bool = false  # State flag to track if the player is walking

func _ready():
	# Initialize the target position to the player's starting position
	target_x = position.x
	target_y = position.y

	# Play the "idle_down" animation for all parts at the start
	_set_animation("idle_down")

func _input(event):
	# If the mouse is clicked, set the target position
	if event.is_action_pressed("click"):
		var mouse_position = get_global_mouse_position()
		target_x = mouse_position.x
		target_y = mouse_position.y

func _physics_process(delta: float) -> void:
	# Calculate the difference between the current position and the target
	var dx = target_x - position.x
	var dy = target_y - position.y
	var distance = sqrt(dx * dx + dy * dy)  # Calculate the distance to the target

	if distance > 10:  # Move toward the target if far enough away
		var direction_x = dx / distance
		var direction_y = dy / distance
		position.x += direction_x * speed * delta
		position.y += direction_y * speed * delta
		
		# Update animations based on movement direction
		_update_animation(direction_x, direction_y)
		
		# Start playing the walking sound if not already playing
		if not is_walking:
			AudioController.play_walk()
			is_walking = true
	else:  # Stop moving and set idle animation
		_set_idle_animation()
		if is_walking:
			AudioController.stop_walk()  # Stop the walking sound
			is_walking = false  # Update walking state
		destination_reached.emit()
		

# Update animations based on the movement direction
func _update_animation(direction_x: float, direction_y: float):
	var animation_name = ""
	AudioController.play_walk()
	if abs(direction_x) > abs(direction_y):  # Horizontal movement dominates
		if direction_x > 0:
			animation_name = "walk_right"
		else:
			animation_name = "walk_left"
	else:  # Vertical movement dominates
		if direction_y > 0:
			animation_name = "walk_down"
		else:
			animation_name = "walk_up"

	_set_animation(animation_name)

# Set the correct idle animation based on the last movement direction
func _set_idle_animation():
	var animation_name = ""
	if abs(target_x - position.x) > abs(target_y - position.y):  # Horizontal last movement
		if target_x > position.x:
			animation_name = "idle_right"
		else:
			animation_name = "idle_left"
	else:  # Vertical last movement
		if target_y > position.y:
			animation_name = "idle_down"
		else:
			animation_name = "idle_up"

	_set_animation(animation_name)

# Play the specified animation on the body and all its child parts
func _set_animation(animation_name: String):
	body.play(animation_name)  # Play animation on the main body
	for part in body_parts:
		if part is AnimatedSprite2D:  # Ensure the part is an AnimatedSprite2D
			part.play(animation_name)
