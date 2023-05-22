extends Node

class_name Enemy

@export var contact_damage: int
@export var health: Health

func _on_hurt_box_body_entered(body):
	if body is Player:
		(body as Player).health.take_damage(contact_damage)


func _on_hit_box_body_entered(body):
	if body is Potion:
		(body as Potion).hit_enemy(self)
