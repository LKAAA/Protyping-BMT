extends ItemData
class_name ItemDataConsumable

@export var heal_value: int
@export var mana_value: int
@export var stamina_value: int

@export var item_to_give_id: int = -1
@export var item_to_give_quantity: int = 1

func use(target) -> void:
	pass
