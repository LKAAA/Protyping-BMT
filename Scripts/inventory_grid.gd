extends GridContainer
class_name InventoryGrid

const INVENTORY_SLOT = preload("uid://ccmyhhc71d7ao")

var attached_inventory: InventorySystem = null

func populate_grid(inventory_system: InventorySystem) -> void:
	for child in get_children():
		child.queue_free()
	
	attached_inventory = inventory_system
	
	for index in attached_inventory.inventory.size():
		var inv_slot: InventorySlot = INVENTORY_SLOT.instantiate()
		inv_slot.item_stack = attached_inventory.inventory[index]
		add_child(inv_slot)
		if attached_inventory.locked[index]:
			inv_slot.background.self_modulate = Color.RED
		
