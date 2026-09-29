extends Resource
class_name Inventory

...

func add_item(item : Item, quantity : int = 1) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.quantity += quantity
			return true
	return false