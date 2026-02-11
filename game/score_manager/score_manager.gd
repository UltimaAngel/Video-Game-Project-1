extends Node

@export var _map: TileMapLayer
@export var _win_text: Label

var map_winning_score: int = 25
var map_score: int = 0
var total_score: int = 0


func _ready():
	_map.ready.connect(_on_map_ready)


func _on_map_ready():
	_map.get_node("%SpawnManager").spawned_enemy_removed.connect(_on_spawned_enemy_removed)


func _on_spawned_enemy_removed():
	map_score += 1
	total_score += 1
	if map_score == map_winning_score:
		_win_text.global_position = PlayerManager.player.global_position - Vector2(117, 47)
		_win_text.visible = true
		print("You win!")
	print("Total Score: ", total_score)
