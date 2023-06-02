extends Node

class_name Health

signal damaged(damage)
signal died

@onready var timer = $Timer

@export var max_hp := 10
@export var invulnerability_after_damage_s := 0.0
var hp
var can_take_damage := true

func _ready():
	hp = max_hp

func take_damage(damage: int):
	if not can_take_damage:
		return
		
	if damage <= 0:
		return
		
	hp -= damage
	emit_signal("damaged", damage)
	
	if invulnerability_after_damage_s > 0.0 + 1e-5:
		can_take_damage = false
		timer.start(invulnerability_after_damage_s)
#		print("started timer")
	
	if hp <= 0:
		emit_signal("died")
		get_parent().queue_free()
	
	# play damage label animation
	$CanvasLayer/Label.text = str(damage)
	$AnimationPlayer.play("ShowDamage")


func _on_timer_timeout():
	print("can take damage again")
	can_take_damage = true
