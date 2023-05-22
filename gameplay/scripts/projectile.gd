extends CharacterBody2D

@export var speed: Vector2
@onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(delta * PI)
	var collision = move_and_collide(delta * velocity)
	if collision and collision.get_collider() is Player:
		print("hit player")
		queue_free()


func _on_rotate_timer_timeout():
	sprite.rotate(0.25 * PI)
