extends Area2D

class_name Collectible

@export var item: Item

@onready var sprite = $Pivot/Sprite2D
@onready var sprite_background = $Pivot/SpriteBackground
@onready var player = $AnimationPlayer

func init(item: Item):
	self.item = item
	sprite.texture = item.sprite
	sprite_background.texture = item.sprite

func _ready():
	init(item)

func _on_body_entered(body):
	print("entered body")
	if body is Player:
		(body as Player).inventory.add(item)
#		position = body.position
		player.play("PickedUp")
