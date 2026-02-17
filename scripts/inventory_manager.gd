extends Node

var inventory = {} # item_name: count
var slots = ["", "", "", "", ""] # 5 hotbar slots

func add_item(item_name: String, amount: int = 1):
	if inventory.has(item_name):
		inventory[item_name] += amount
	else:
		inventory[item_name] = amount
		# Auto-equip to first empty slot
		var in_slot = false
		for s in slots:
			if s == item_name:
				in_slot = true
				break
		if not in_slot:
			for i in range(slots.size()):
				if slots[i] == "":
					slots[i] = item_name
					break
	
	print("Inventory updated: ", inventory)
	update_ui()

func craft_item(item_name: String, cost_item: String, cost_amount: int):
	if inventory.get(cost_item, 0) >= cost_amount:
		inventory[cost_item] -= cost_amount
		if inventory[cost_item] <= 0:
			inventory.erase(cost_item)
			# Remove from slots if empty
			for i in range(slots.size()):
				if slots[i] == cost_item:
					slots[i] = ""
		
		add_item(item_name, 1)
		print("Crafted: ", item_name)
		update_ui()
	else:
		print("Not enough resources to craft ", item_name)

func update_ui():
	var ui = get_tree().root.find_child("UI", true, false)
	if ui:
		var hotbar = ui.find_child("Hotbar", true, false)
		if hotbar:
			# Update slots
			for i in range(slots.size()):
				var slot_path = "Slot" + str(i+1)
				if hotbar.has_node(slot_path):
					var slot = hotbar.get_node(slot_path)
					var label = slot.get_node_or_null("Label")
					if not label:
						label = Label.new()
						label.name = "Label"
						slot.add_child(label)
					
					var item = slots[i]
					if item != "":
						var count = inventory.get(item, 0)
						label.text = item + ": " + str(count)
					else:
						label.text = ""

		# Add craft buttons if they don't exist
		var actions = ui.find_child("Actions", true, false)
		if actions and not actions.has_node("CraftSword"):
			var btn = Button.new()
			btn.name = "CraftSword"
			btn.text = "Sword"
			btn.position = Vector2(0, -60) # Above existing buttons
			btn.pressed.connect(func(): craft_item("Sword", "Wood", 5))
			actions.add_child(btn)
