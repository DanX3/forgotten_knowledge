extends RigidBody2D

class_name Potion
@export var effect_scene: PackedScene

func _on_timer_timeout():
	_create_effect()
	queue_free()

func hit_enemy(enemy: Enemy):
	enemy.health.take_damage(10.0)
	_create_effect()
	queue_free()

func _create_effect():
	if effect_scene:
		var effect = effect_scene.instantiate()
		effect.position = position
		get_parent().call_deferred("add_child", effect)
		effect = null
