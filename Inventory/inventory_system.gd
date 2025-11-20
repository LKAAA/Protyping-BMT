extends Node2D
class_name InventorySystem

signal inventory_updated(inventory_system: InventorySystem, index: int)
signal inventory_interacted(inventory_system: InventorySystem, index: int, button: int)

@export var inventory: Array[ItemStack]
@export var locked: Array[bool]
@export var inventory_slots: int = 36
@export var locked_slots: int = 0

func _ready() -> void:
	populate_inventory(inventory_slots)

func populate_inventory(inv_slots: int) -> bool:
	inventory.resize(inv_slots)
	locked.resize(inv_slots)
	for i in range(locked_slots):
		print(i)
		locked[i] = true
	
	locked.reverse()
	
	return true

func add_item_stack(item_stack: ItemStack) -> bool:
	if not item_stack: 
		return false
	
	if not can_place_item_stack(item_stack):
		return false
	
	for index in inventory.size():
		var slot = inventory[index]
		if slot and slot.can_fully_merge_with(item_stack):
			slot.fully_merge_with(item_stack)
			inventory_updated.emit(self, index)
			return true
	
	for index in range(inventory.size()): 
		var slot = inventory[index]
		if slot and slot.can_partially_merge_with(item_stack, self):
			
			var leftover = slot.partially_merge_with(item_stack)
			inventory_updated.emit(self, index)
			
			if leftover.quantity == 0:
				return true
			
			item_stack = leftover
	
	for index in inventory.size():
		if not inventory[index] and not locked[index]:
			inventory[index] = item_stack
			inventory_updated.emit(self, index)
			return true
	
	print("Item Stack has ", item_stack.quantity, " left in it")
	
	return false

func can_place_item_stack(item_stack: ItemStack) -> bool:
	if not item_stack: 
		return false
	
	for index in inventory.size():
		if not inventory[index] and not locked[index]:
			return true
	
	for index in inventory.size():
		if inventory[index] and not locked[index]:
			if inventory[index].can_fully_merge_with(item_stack):
				return true
	
	for index in inventory.size():
		if inventory[index] and not locked[index]:
			if inventory[index].can_partially_merge_with(item_stack, self):
				var leftover = inventory[index].partially_merge_with(item_stack)
				if leftover: 
					for other_index in inventory.size():
						if not inventory[other_index] and not locked[other_index]:
							return true
				return true
	
	return false

func add_item_data(item_data: ItemData, quantity: int = 1) -> bool:
	print("Excess ", quantity)
	var excess = quantity
	while excess > 0:
		if excess > ItemManager.MAX_STACK_SIZE:
			excess -= ItemManager.MAX_STACK_SIZE
			var item_stack = create_item_stack(item_data, ItemManager.MAX_STACK_SIZE)
			if not add_item_stack(item_stack):
				return false
		else:
			var item_stack = create_item_stack(item_data, excess)
			if not add_item_stack(item_stack):
					return false
			excess = 0
	
	return true

func create_item_stack(item_data: ItemData, quantity: int = 1) -> ItemStack: 
	var item_stack = ItemStack.new()
	
	item_stack.item_data = item_data
	item_stack.quantity = quantity
	
	return item_stack

func has_open_slots() -> bool:
	return inventory.size() < inventory_slots
