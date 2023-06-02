extends Node2D

@export var enemies: Array[PackedScene]

func spawn_start():
	for i in range(5):
		spawn_enemy(enemies[randi() % enemies.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy(enemy: PackedScene):
	var new_enemy = enemy.instantiate() as Enemy
	new_enemy.died.connect(_enemy_died)
	get_parent().call_deferred("add_child", new_enemy)
	var spawns = get_tree().get_nodes_in_group("spawn")
	new_enemy.global_position = spawns[randi() % spawns.size()].global_position
	

func _enemy_died(enemy: Enemy):
	spawn_enemy(enemies[randi() % enemies.size()])
