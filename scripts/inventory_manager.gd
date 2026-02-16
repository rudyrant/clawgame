extends Node

var inventory = {} # item_name: count

func add_item(item_name: String, amount: int = 1):
	if inventory.has(item_name):
		inventory[item_name] += amount
	else:
		inventory[item_name] = amount
	print("Inventory updated: ", inventory)
	update_ui()

func update_ui():
	var ui = get_tree().root.find_child("UI", true, false)
	if ui:
		var hotbar = ui.find_child("Hotbar", true, false)
		if hotbar and inventory.has("Wood"):
			var slot1 = hotbar.get_node("Slot1")
			# For prototype: simple label update
			var label = slot1.get_node_or_null("Label")
			if not label:
				label = Label.new()
				label.name = "Label"
				slot1.add_child(label)
			label.text = "Wood: " + str(inventory["Wood"])
