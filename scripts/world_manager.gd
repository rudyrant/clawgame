extends Node

@export var map_width = 128
@export var map_height = 128
@export var noise_scale = 15.0
@export var tree_scene: PackedScene = preload("res://prefabs/world/tree.tscn")

var noise = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.frequency = 1.0 / noise_scale
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	generate_world()
	spawn_objects()

func generate_world():
	var tile_map = get_parent().get_node_or_null("TileMap")
	if not tile_map:
		print("Error: TileMap node not found")
		return

	for x in range(map_width):
		for y in range(map_height):
			var val = noise.get_noise_2d(x, y)
			# Basic tile selection: 0 for water (val < 0), 1 for grass (val >= 0)
			var tile_coord = Vector2i(0, 0) if val < 0 else Vector2i(1, 0)
			tile_map.set_cell(0, Vector2i(x, y), 0, tile_coord)
	
	print("World generation complete: ", map_width, "x", map_height)

func spawn_objects():
	for i in range(100):
		var pos = Vector2(randf_range(0, map_width * 16), randf_range(0, map_height * 16))
		var tree = tree_scene.instantiate()
		tree.position = pos
		add_child(tree)
