extends Node2D


func set_elevation_for(tile_set: TileSet, elevation: int) -> TileSet:
	for i_layer in range(tile_set.get_physics_layers_count()):
		tile_set.set_physics_layer_collision_layer(i_layer, 2 ** (8 + elevation + i_layer))
	return tile_set

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i_child in range(get_child_count()):
		var child: TileMap = get_children()[i_child]
		var tile_set: TileSet = child.tile_set.duplicate(true)
		child.tile_set = set_elevation_for(tile_set, i_child)
