extends Area2D

class_name Collectible

@export var item: Item

@onready var sprite = $Pivot/Sprite2D
@onready var sprite_background = $Pivot/SpriteBackground
@onready var player = $AnimationPlayer

const BounceHeight = 20.0

func init(item: Item):
	self.item = item

func _ready():
	self.item = item
	sprite.texture = item.sprite
	sprite_background.texture = item.sprite
	
	# play tween animation
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + BounceHeight * Vector2.UP, 0.25)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "position", position, 0.5)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.play()

func _on_body_entered(body):
	print("entered body")
	if body is Player:
		(body as Player).inventory.add(item)
#		position = body.position
		player.play("PickedUp")
