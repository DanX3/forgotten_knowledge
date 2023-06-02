extends Control

@export var inventory: Inventory
@export var shooter: PotionShooter

@onready var label = $HBoxContainer/Label
@onready var progress = $HBoxContainer/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_amount()

func refresh_amount():
	print("refresh amount")
	var uses = 99
	var max_uses = 99
	for item in shooter.items_needed:
		uses = min(uses, inventory.count_item(item))
		max_uses = min(max_uses, item.max_count)
	label.text = str(uses) + " / " + str(max_uses)
	progress.value = uses
	progress.max_value = max_uses

func _on_inventory_item_used(item):
	refresh_amount()


func _on_inventory_item_added(item):
	refresh_amount()
