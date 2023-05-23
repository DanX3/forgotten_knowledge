extends Node2D

class_name Enemy

@export var contact_damage: int
@export var health: Health
@export var collectible_scene : PackedScene
@export var drops: Array[Drop]

func _on_hurt_box_body_entered(body):
	if body is Player:
		(body as Player).health.take_damage(contact_damage)


func _on_hit_box_body_entered(body):
	if body is Potion:
		(body as Potion).hit_enemy(self)

func _exit_tree():
	for drop in drops:
		if randf_range(0.0, 1.0) < drop.drop_chance:
			var new_collectible = collectible_scene.instantiate() as Collectible
			new_collectible.init(drop.item)
			get_parent().add_child.call_deferred(new_collectible)
			new_collectible.position = position

@onready var player = $AnimationPlayer

func _on_health_component_damaged(damage):
	player.play("damaged")
