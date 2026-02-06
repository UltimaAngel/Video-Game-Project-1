extends Node

@export var _map: TileMapLayer

var map_score: int = 0
var total_score: int = 0


func _ready():
	_map.ready.connect(_on_map_ready)


# Access SpawnManager using its unique name?
func _on_map_ready():
	_map.get_node("%SpawnManager").spawned_enemy_removed.connect(_on_spawned_enemy_removed)


func _on_spawned_enemy_removed():
	map_score += 1
	total_score += 1
