extends EnemyBehaviour

@export var walk_speed = 400

@onready var close_threshold = $CloseThreshold
@onready var player = $WalkPlayer

enum RatState {
	Rest,
	StayFarFromPlayer,
	WalkTowardsPlayer,
	WalkRandom
}

var StateSequence = [
	RatState.StayFarFromPlayer, 
	RatState.WalkRandom,
	RatState.WalkTowardsPlayer,
	RatState.WalkTowardsPlayer,
	RatState.Rest
]

var state_index := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	StateSequence.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_switch_state_timer_timeout():
	state_index = (state_index + 1) % StateSequence.size()
	match StateSequence[state_index]:
		RatState.WalkRandom:
			reset_constant_force()
			add_constant_force_random(walk_speed)
			player.play("walk")
		RatState.StayFarFromPlayer:
			var player_dist = (get_player().global_position - get_parent().global_position).length()
			reset_constant_force()
			add_constant_force_against_player(-walk_speed)# *
#				1.0 if player_dist < close_threshold.position.length() else -1.0)
			player.play("walk")
		RatState.WalkTowardsPlayer:
			reset_constant_force()
			add_constant_force_against_player(walk_speed)
			player.play("walk")
		RatState.Rest:
			reset_constant_force()
			player.stop()
