extends Node2D

const BASE_STRENGTH = 10.0

signal shoot(name, strength)

@export var action_name: String
@export var max_charge_duration_s = 1.0
@onready var timer = $Timer

# tells when charging started
# -1.0 if not charging
var charge_time_start = -1.0

func _unhandled_input(event):
	if Input.is_action_just_pressed(action_name):
		$Timer.start()
	
	if Input.is_action_just_released(action_name):
		# release charged potion
		if charge_time_start > 0.0:
			var strength = (0.001 * Time.get_ticks_msec() - charge_time_start) / max_charge_duration_s
			strength = min(1.0, strength)
			emit_signal("shoot", action_name, strength)
			charge_time_start = -1.0
		# single press release
		else:
			emit_signal("shoot", action_name, 0.3)
	

func _on_timer_timeout():
	if Input.is_action_pressed(action_name):
		charge_time_start = 0.001 * Time.get_ticks_msec()
		

func _draw():
	pass
