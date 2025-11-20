extends Control

var test := false

@onready var inventory_system: InventorySystem = %InventorySystem
@onready var inventory_grid: InventoryGrid = %InventoryGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_grid.populate_grid(inventory_system)

func _on_button_pressed() -> void:
	if not Popups.active: 
		if test:
			Popups.show_item_popup(ItemManager.get_item_by_id(1))
			test = false
		else:
			Popups.show_item_popup(ItemManager.get_item_by_id(2))
			test = true
	else:
		Popups.hide_item_popup()

func _on_add_wood_button_100_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1), 125): 
		print("Could not add")
	
	inventory_grid.populate_grid(inventory_system)

func _on_add_wood_button_5_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(2), 1): 
		print("Could not add")
	
	inventory_grid.populate_grid(inventory_system)

func _on_add_wood_button_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1)): 
		print("Could not add")
	
	inventory_grid.populate_grid(inventory_system)
