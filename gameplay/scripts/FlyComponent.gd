extends EnemyBehaviour

@onready var timer = $Timer
@onready var player = $AnimationPlayer

func _init():
	update_configuration_warnings()

const MovePower := 5000.0
const MaxTimeouts := 3
var timeout_to_rest := MaxTimeouts

func _on_timer_timeout():
	timeout_to_rest -= 1
	if timeout_to_rest <= 0:
		timeout_to_rest = MaxTimeouts
		move_random_dir(7500.0)
	else:
		player.play("MoveToPlayer")
	timer.start()

