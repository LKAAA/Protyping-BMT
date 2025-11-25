extends Control

var test := false

@onready var external_inventory: InventorySystem = $ExternalInventory
@onready var inventory_system: InventorySystem = %InventorySystem
@onready var menu_ui: Menu_UI = %Menu_UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_ui._set_player_inventory(inventory_system)

func _on_button_pressed() -> void:
	print("Set external inventory")
	menu_ui._set_external_inventory(external_inventory)

func _on_add_wood_button_100_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1), 125): 
		print("Could not add")

func _on_add_wood_button_5_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(2), 1): 
		print("Could not add")

func _on_add_wood_button_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1)): 
		print("Could not add")
