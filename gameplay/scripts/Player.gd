extends CharacterBody2D


const SPEED = 100.0
var shootDir = Vector2.ZERO
@export var potion_base: PackedScene
@export var potion_light: PackedScene
@export var potion_heavy: PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func move_toward_v2(from: Vector2, to: Vector2, delta: float) -> Vector2:
	return Vector2(move_toward(from.x, to.x, delta), move_toward(from.y, to.y, delta))

@onready var pivot = $Pivot

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	if direction:
		velocity = move_toward_v2(velocity, direction * SPEED * Vector2.ONE, 0.2 * SPEED)
		if direction.x != 0:
			pivot.scale.x = -1.0 if direction.x < 0 else 1.0
		if abs(direction.x) > abs(direction.y):
			shootDir = Vector2(direction.x, 0.0).normalized()
		else:
			shootDir = Vector2(0.0, direction.y).normalized()
		queue_redraw()
		
	else:
		velocity = move_toward_v2(velocity, Vector2.ZERO, 0.1 * SPEED)

	move_and_slide()

func _draw():
	draw_line(Vector2.ZERO, 20.0 * shootDir, Color.REBECCA_PURPLE, 3.0)


func _on_potion_shooter_shoot(name, strength):
	var new_potion: Potion
	match name:
		"potion_base":
			new_potion = potion_base.instantiate()
		"potion_light":
			new_potion = potion_light.instantiate()
		"potion_heavy":
			new_potion = potion_heavy.instantiate()
			
	get_parent().add_child(new_potion)
	new_potion.position = position
	new_potion.linear_velocity = shootDir * 600.0 * strength
	print("shot potion " + name + " with strength " + str(strength))
