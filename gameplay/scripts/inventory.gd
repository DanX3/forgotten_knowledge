extends Node

class_name Inventory

# map <String, int> : <item code, count>
var items = {}

func add(item: Item):
	if not items.has(item.code):
		items[item.code] = 0
	items[item.code] += 1
	print_debug(item.code + ": " + str(items[item.code]))

func has_item(item: Item):
	if not items.has(item.code):
		return false
	return items[item.code] > 0

func has_items(items: Array[Item]):
	for item in items:
		if not has_item(item):
			return false
	return true

func has_code(item_code: String):
	return items.has(item_code)

func use(items_to_use: Array[Item]) -> bool:
	# first check if every item is available
	for item in items_to_use:
		if not has_item(item):
			return false
	
	for item in items_to_use:
		items[item.code] -= 1
		print_debug(item.code + ": " + str(items[item.code]))
		assert(items[item.code] >= 0)
	return true
