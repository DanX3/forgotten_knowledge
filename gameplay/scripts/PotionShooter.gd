extends Node2D

class_name PotionShooter

signal shoot(name, strength, items_needed)

@export var action_name: String
@export var max_charge_duration_s = 1.0
@export var items_needed: Array[Item]
@export var cooldown := 0.5

@onready var timer = $Timer
@onready var progress = $TextureProgressBar

var shoot_at := -1.0
var last_shot_at := -1.0

func _ready():
	progress.hide()

# tells when charging started
# -1.0 if not charging
var charge_time_start = -1.0

func _unhandled_input(event):
	if Input.is_action_just_pressed(action_name):
		$Timer.start()
	
	if Input.is_action_just_released(action_name):
		progress.hide()
		# release charged potion
		if charge_time_start > 0.0:
			emit_signal("shoot", action_name, _get_strength(), items_needed)
			last_shot_at = 0.001 * Time.get_ticks_msec()
			charge_time_start = -1.0
		# single press release
		else:
			if _can_shoot():
				emit_signal("shoot", action_name, 0.3, items_needed)
				last_shot_at = 0.001 * Time.get_ticks_msec()
			else:
				shoot_at = last_shot_at + cooldown
				print("Shooting at " + str(shoot_at))

func _process(delta):
	progress.value =  _get_strength()
	if shoot_at > 0.0 and 0.001 * Time.get_ticks_msec() > shoot_at:
		shoot_at = -1.0
		emit_signal("shoot", action_name, 0.3, items_needed)
		last_shot_at = 0.001 * Time.get_ticks_msec()
	

func _on_timer_timeout():
	if Input.is_action_pressed(action_name):
		charge_time_start = 0.001 * Time.get_ticks_msec()
		progress.show()

func _get_strength() -> float:
	var res = (0.001 * Time.get_ticks_msec() - charge_time_start) / max_charge_duration_s
	return min(res, 0.8) * min(res, 0.8)

func _can_shoot() -> bool:
	return last_shot_at + cooldown < 0.001 * Time.get_ticks_msec()
		

func _draw():
	pass
