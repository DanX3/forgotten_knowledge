extends Node

class_name Inventory

signal item_added(item)
signal item_used(item)

# map <String, int> : <item code, count>
var items = {}

func add(item: Item):
	if not items.has(item.code):
		items[item.code] = 0
	items[item.code] += 1
	emit_signal("item_added", item)
	print_debug(item.code + ": " + str(items[item.code]))

func has_item(item: Item):
	if not items.has(item.code):
		return false
	return items[item.code] > 0

func has_items(items: Array[Item]) -> bool:
	for item in items:
		if not has_item(item):
			return false
	return true

func has_code(item_code: String) -> bool:
	return items.has(item_code)

func count_item(item: Item) -> int:
	if not has_item(item):
		return 0
	return items[item.code]

func use(items_to_use: Array[Item]) -> bool:
	# first check if every item is available
	for item in items_to_use:
		if not has_item(item):
			return false
	
	for item in items_to_use:
		items[item.code] -= 1
		emit_signal("item_used", items[item.code])
		print_debug(item.code + ": " + str(items[item.code]))
		assert(items[item.code] >= 0)
	return true
