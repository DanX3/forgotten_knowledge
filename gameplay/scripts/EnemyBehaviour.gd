extends Node

class_name EnemyBehaviour

func get_player() -> Player:
	return get_tree().get_first_node_in_group("player") as Player

func get_player_dir() -> Vector2:
	return get_player().global_position - get_parent().global_position

func _get_configuration_warnings():
	if not get_parent() is RigidBody2D:
		return ["Parent of " + name + " is supposed to be a RigidBody2D"]
	return []

func _rand_dir() -> Vector2:
	return Vector2.LEFT.rotated(randf_range(0.0, 2.0 * PI))

func get_rigidbody() -> RigidBody2D:
	return get_parent() as RigidBody2D

func apply_force_against_player(force: float) -> void:
	get_rigidbody().apply_central_force(force * get_player_dir().normalized())

func move_random_dir(force: float):
	get_rigidbody().apply_central_force(force * _rand_dir())

func add_constant_force_random(force: float) -> void:
	get_rigidbody().add_constant_central_force(force * _rand_dir())

func add_constant_force_against_player(force: float) -> void:
	get_rigidbody().add_constant_central_force(force * get_player_dir().normalized())

func reset_constant_force() -> void:
	get_rigidbody().constant_force = Vector2.ZERO
