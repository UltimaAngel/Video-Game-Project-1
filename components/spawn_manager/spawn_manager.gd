extends Node2D

signal spawned_enemy_removed
signal final_wave_cleared

# Allows for a variable number of enemy types to spawn
@export var enemy_array: Array[PackedScene]
# The number of enemies to spawn at a time
@export var enemy_num: int = 1
# Max number of waves until map cleared
@export var max_waves: int = 3
# How many seconds until next spawn
@export var min_spawn_break: float = 5

var wave_num: int = 0
var _map: TileMapLayer
var _map_used_rect_size := Vector2i(0, 0)
var _tile_length: int = 16
var _timer := Timer.new()


func _ready():
	get_parent().ready.connect(_on_map_ready)
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func _on_map_ready():
	_map = get_parent()
	_map_used_rect_size = _map.get_used_rect().size
	_tile_length = _map.tile_set.tile_size.x
	_timer.start(min_spawn_break)


func _on_timer_timeout():
	for e in enemy_num:
		var rand_pos: Vector2i
		# Keep selecting a random tile within rectangular map boundary to spawn enemy on until
		# selected tile exists and does not have a collision layer
		while (1):
			rand_pos = Vector2i(
				randi_range(0, _map_used_rect_size.x - 1),
				randi_range(0, _map_used_rect_size.y - 1),
			)
			var rand_tile_data: TileData = _map.get_cell_tile_data(rand_pos)
			if rand_tile_data and rand_tile_data.get_collision_polygons_count(0) == 0:
				break
		var rand_enemy: Entity = enemy_array.pick_random().instantiate()
		rand_enemy.global_position = _tile_length * Vector2(rand_pos)
		add_child(rand_enemy)
		rand_enemy.health_component.destroyed.connect(_on_rand_enemy_destroyed)
	wave_num += 1
	if wave_num == max_waves:
		_timer.stop()
		final_wave_cleared.emit()


func _on_rand_enemy_destroyed(_hitbox):
	spawned_enemy_removed.emit()
