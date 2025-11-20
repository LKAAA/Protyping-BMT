extends Control
class_name InventorySlot

@onready var sprite: TextureRect = %Sprite
@onready var quantity_label: RichTextLabel = %Quantity_Label
@onready var background: TextureRect = %Background

var item_stack: ItemStack

func _ready() -> void:
	quantity_label.text = ""
	update_slot(item_stack)

func update_slot(item_s: ItemStack) -> void:
	item_stack = item_s
	if item_stack:
		sprite.texture = item_stack.item_data.sprite
		if item_stack.quantity > 1:
			quantity_label.text = "%d" % item_stack.quantity
			quantity_label.show() 
		else:
			quantity_label.hide()
	else:
		quantity_label.hide()


func _on_mouse_entered() -> void:
	if item_stack and not Popups.active: 
		Popups.show_item_popup(item_stack.item_data)


func _on_mouse_exited() -> void:
	Popups.hide_item_popup()
