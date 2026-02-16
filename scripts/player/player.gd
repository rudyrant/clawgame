extends CharacterBody2D

@export var speed = 150.0

var input_direction = Vector2.ZERO

func _ready():
	# Connect UI buttons if they exist in the scene tree
	# This assumes the UI scene is added to the same level or accessible
	# For simplicity in this prototype, we'll check for the existence of the UI node
	var ui = get_tree().root.find_child("UI", true, false)
	if ui:
		setup_ui_signals(ui)

func setup_ui_signals(ui):
	var dpad = ui.find_child("DPAD", true, false)
	if dpad:
		dpad.get_node("Up").button_down.connect(func(): input_direction.y -= 1)
		dpad.get_node("Up").button_up.connect(func(): input_direction.y += 1)
		dpad.get_node("Down").button_down.connect(func(): input_direction.y += 1)
		dpad.get_node("Down").button_up.connect(func(): input_direction.y -= 1)
		dpad.get_node("Left").button_down.connect(func(): input_direction.x -= 1)
		dpad.get_node("Left").button_up.connect(func(): input_direction.x += 1)
		dpad.get_node("Right").button_down.connect(func(): input_direction.x += 1)
		dpad.get_node("Right").button_up.connect(func(): input_direction.x -= 1)
	
	var actions = ui.find_child("Actions", true, false)
	if actions:
		actions.get_node("Hit").pressed.connect(_on_hit_pressed)
		actions.get_node("Interact").pressed.connect(_on_interact_pressed)

func _physics_process(_delta):
	# Combine keyboard/controller input with UI input
	var keyboard_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Clamp input_direction to handle multiple simultaneous UI presses correctly
	var final_direction = (keyboard_dir + input_direction).normalized()
	
	velocity = final_direction * speed
	move_and_slide()

func _on_hit_pressed():
	print("Hit pressed")
	var targets = $InteractionArea.get_overlapping_bodies()
	for target in targets:
		if target.has_method("hit"):
			target.hit(1)

func _on_interact_pressed():
	print("Interact pressed")
	var targets = $InteractionArea.get_overlapping_bodies()
	for target in targets:
		if target.has_method("interact"):
			target.interact()
