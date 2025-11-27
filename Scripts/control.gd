extends Control

var test := false

@onready var chest: Node2D = %Chest
@onready var inventory_system: InventorySystem = %InventorySystem
@onready var menu_ui: Menu_UI = %Menu_UI

var external_inventory_on: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_ui._set_player_inventory(inventory_system)
	ItemManager.player_inventory_system = inventory_system

func _on_button_pressed() -> void:
	if not external_inventory_on:
		menu_ui._set_external_inventory(chest)
		menu_ui.external_inventory.visible = true
		menu_ui.external = true
		external_inventory_on = true
	else:
		menu_ui.clear_external_inventory()
		menu_ui.external_inventory.visible = false
		menu_ui.external = false
		external_inventory_on = false

func _on_add_wood_button_100_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1), 125): 
		print("Could not add")

func _on_add_wood_button_5_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(2), 1): 
		print("Could not add")

func _on_add_wood_button_pressed() -> void:
	if not inventory_system.add_item_data(ItemManager.get_item_by_id(1)): 
		print("Could not add")
