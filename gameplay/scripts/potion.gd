extends RigidBody2D

class_name Potion

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()

func hit_enemy(enemy: Enemy):
	enemy.health.take_damage(10.0)
	queue_free()
