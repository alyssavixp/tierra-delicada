extends CharacterBody2D

@export var speed: float = 400  # Movement speed of the player

# Target position as separate x and y components
var target_x = 0
var target_y = 0

@onready var animated_sprite: AnimatedSprite2D = $body  # Reference to AnimatedSprite2D child node

func _ready():
	# Initialize the target position to the player's starting position
	target_x = position.x
	target_y = position.y

	# Play the "idle_down" animation at the start
	animated_sprite.play("idle_down")

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

	# Move toward the target if far enough away
	if distance > 10:
		var direction_x = dx / distance
		var direction_y = dy / distance
		position.x += direction_x * speed * delta
		position.y += direction_y * speed * delta

		# Update animation based on movement direction
		_update_animation(direction_x, direction_y)
	else:
		# Stop moving and set idle animation
		_set_idle_animation()

# Update animations based on the movement direction
func _update_animation(direction_x: float, direction_y: float):
	if abs(direction_x) > abs(direction_y):  # Horizontal movement dominates
		if direction_x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")
	else:  # Vertical movement dominates
		if direction_y > 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_up")

# Set the correct idle animation based on the last movement direction
func _set_idle_animation():
	if abs(target_x - position.x) > abs(target_y - position.y):  # Horizontal last movement
		if target_x > position.x:
			animated_sprite.play("idle_right")
		else:
			animated_sprite.play("idle_left")
	else:  # Vertical last movement
		if target_y > position.y:
			animated_sprite.play("idle_down")
		else:
			animated_sprite.play("idle_up")
