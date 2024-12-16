extends Node2D

@export var mute: bool = false  # Toggle to mute/unmute all sounds

#func _ready():
	### Start playing ambience sound if not muted
	##if not mute:
		##play_ambience()

## Function to play ambience sound
#func play_ambience():
	#if not mute:
		#$ambience.play()

# Function to play the walking sound
func play_walk() -> void:
	if not mute and !$walk.playing:  # Ensure the sound doesn't overlap
		$walk.play()

# Function to stop the walking sound
func stop_walk() -> void:
	if $walk.playing:
		$walk.stop()
	
#func play_barrier() -> void:
	#if not mute:
		#$walk.stop()
		#$barrier.play()
