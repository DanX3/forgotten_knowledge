extends Node

@export var target: Node2D
@export var facing_left := true
var player: Player = null

func _process(delta):
	if not player:
		player = get_tree().get_nodes_in_group("player")[0]
	
	var dir_x = sign(player.global_position.x - get_parent().global_position.x)
	if facing_left:
		dir_x *= -1.0
	target.scale.x = dir_x
