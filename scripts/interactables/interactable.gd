extends StaticBody2D

@export var health = 3
@export var is_breakable = true

func hit(damage: int):
	if not is_breakable: return
	health -= damage
	if health <= 0:
		die()

func die():
	InventoryManager.add_item("Wood", 1)
	queue_free()
