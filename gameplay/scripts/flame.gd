extends Node2D

var target_enemy: Enemy = null

const speed := 50.0

var enemies_hit = []
@export var damage := 10

@onready var dist_to_marker = $Marker2D.position.length()
@onready var player = $AnimationPlayer

func _process(delta):
	# choose target enemy in range and still not targeted
	if target_enemy == null:
		var min_dist_to_enemy = 1e20
		for enemy in get_tree().get_nodes_in_group("enemy"):
			var dist_to_enemy = (enemy.position - position).length()
			if not enemies_hit.has(enemy) \
			 and dist_to_enemy < dist_to_marker \
			 and dist_to_enemy < min_dist_to_enemy:
				min_dist_to_enemy = dist_to_enemy
				target_enemy = enemy
		# no valid enemy found
		if target_enemy == null:
			if not player.is_playing():
				player.play("Disappear")
			return
	
	var dir_before = (target_enemy.position - position).normalized()
	$Ghost.rotation = atan2(dir_before.y, dir_before.x)
	position += delta * speed * dir_before
	var dir_after = (target_enemy.position - position).normalized()
	# different directions means it reached the target
	if dir_before.dot(dir_after) < 0.0:
		enemies_hit.append(target_enemy)
		target_enemy.health.take_damage(damage)
		target_enemy = null

var shooting_angle := 0.0

func _on_animated_sprite_2d_animation_finished():
	queue_free()
