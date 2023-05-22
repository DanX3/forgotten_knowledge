extends Node2D

const BASE_STRENGTH = 10.0

signal shoot(name, strength, items_needed)

@export var action_name: String
@export var max_charge_duration_s = 1.0
@export var items_needed: Array[Item]

@onready var timer = $Timer
@onready var progress = $TextureProgressBar

func _ready():
	set_process(false)
	progress.hide()

# tells when charging started
# -1.0 if not charging
var charge_time_start = -1.0

func _unhandled_input(event):
	if Input.is_action_just_pressed(action_name):
		$Timer.start()
	
	if Input.is_action_just_released(action_name):
		set_process(false)
		progress.hide()
		# release charged potion
		if charge_time_start > 0.0:
			emit_signal("shoot", action_name, _get_strength(), items_needed)
			charge_time_start = -1.0
		# single press release
		else:
			emit_signal("shoot", action_name, 0.3, items_needed)

func _process(delta):
	progress.value =  _get_strength()

func _on_timer_timeout():
	if Input.is_action_pressed(action_name):
		charge_time_start = 0.001 * Time.get_ticks_msec()
		progress.show()
		set_process(true)

func _get_strength() -> float:
	var res = (0.001 * Time.get_ticks_msec() - charge_time_start) / max_charge_duration_s
	return min(res, 1.0) * min(res, 1.0)

func _draw():
	pass
