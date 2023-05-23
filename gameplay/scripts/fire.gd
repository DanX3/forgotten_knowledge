extends Area2D

@export var damage := 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for enemy in enemies_inside_fire:
		enemy.health.take_damage(damage)


var enemies_inside_fire: Array[Enemy]

func _on_body_entered(body):
	print("entered enemy")
	enemies_inside_fire.append(body)


func _on_body_exited(body):
	print("exited enemy")
	enemies_inside_fire.erase(body)
	pass # Replace with function body.
