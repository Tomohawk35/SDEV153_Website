extends Resource
class_name Inventory

...

func add_item(item : Item, quantity : int = 1) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.quantity += quantity
			return true
	
	if slots.size() < MAX_SLOTS - 1:
		var new_slot : SlotData = SlotData.new()
		new_slot.item = item
		new_slot.quantity = quantity
		slots.append(new_slot)
		return true
	
	return false