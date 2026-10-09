extends Resource
class_name Inventory

const MAX_SLOTS : int = 20
const SLOT_MAX_ITEM_QUANTITY : int = 99

@export var slots : Array[SlotData] = []