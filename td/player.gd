extends CharacterBody2D

@export var speed: float = 400  # Movement speed of the player
var target_position: Vector2 = Vector2.ZERO  # Position to move towards

# References to child nodes
onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Handle animations

func _input(event):
	if event.is_action_pressed("click"):  # Detect right mouse click
		target_position = get_global_mouse_position()

func _physics_process(delta: float):
	if position.distance_to(target_position) > 5:  # Small buffer to avoid jitter
		velocity = position.direction_to(target_position) * speed
		_update_animation()  # Update animation based on direction
		move_and_slide()
	else:
		velocity = Vector2.ZERO  # Stop moving
		animated_sprite.play("idle")  # Play idle animation

# Update animations based on movement direction
func _update_animation():
	if abs(velocity.x) > abs(velocity.y):  # Horizontal movement dominates
		if velocity.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")
	else:  # Vertical movement dominates
		if velocity.y > 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_up")
