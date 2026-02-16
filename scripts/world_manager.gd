extends Node

@export var map_width = 100
@export var map_height = 100
@export var noise_scale = 20.0

var noise = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.frequency = 1.0 / noise_scale
	generate_world()

func generate_world():
	var tile_map = get_parent().get_node("TileMap")
	# Basic terrain generation logic
	for x in range(map_width):
		for y in range(map_height):
			var val = noise.get_noise_2d(x, y)
			# Placeholder for tile placement
			# tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))
			pass
	print("World generated")
