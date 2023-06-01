extends Area2D

@export var damage := 10
@onready var collision_shape = $CollisionShape2D

var bodies_inside = []

func _ready():
	var points = []
	var radius = ($CollisionShape2D.shape as CircleShape2D).radius
	for i in range(16):
		var angle = float(i) / 16.0 * 2.0 * PI
		points.append(radius * Vector2(cos(angle), sin(angle)))
		print(points[points.size() - 1])
	$Polygon2D.polygon = PackedVector2Array(points)

func _deal_damage_physics():
	for body in bodies_inside:
		if body.has_node("HealthComponent"):
			body.health.take_damage(damage)
			print("damaged " + body.name)

func _on_body_entered(body):
	bodies_inside.push_back(body)


func _on_body_exited(body):
	bodies_inside.erase(body)


func _on_free_timer_timeout():
	queue_free()


func _on_damage_timer_timeout():
	_deal_damage_physics()
