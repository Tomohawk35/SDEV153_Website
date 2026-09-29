extends Resource
class_name Inventory

...

func add_item(item : Item, quantity : int = 1) -> bool:
	var remaining_items_to_add : int = quantity
	for slot in slots:
		if slot.item == item and slot.quantity < SLOT_MAX_ITEM_QUANTITY:
			var items_to_add : int = mini(SLOT_MAX_ITEM_QUANTITY - slot.quantity, remaining_items_to_add)
			slot.quantity += items_to_add
			remaining_items_to_add -= items_to_add
			if remaining_items_to_add == 0:
				return true
	return false