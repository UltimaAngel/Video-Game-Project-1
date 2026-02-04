extends Node2D

@export var enemy: PackedScene
# The number of enemies to spawn at a time
@export var enemy_num: int = 1
# Max number of waves until map cleared
@export var max_waves: int = 3
# How many seconds until next spawn
@export var min_spawn_break: float = 5

var _map: TileMapLayer
var _map_used_rect_size := Vector2i(0, 0)
var _timer := Timer.new()
var _wave_num: int = 0


func _ready():
	get_parent().ready.connect(_on_map_ready)
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func _on_map_ready():
	_map = get_parent()
	_map_used_rect_size = _map.get_used_rect().size
	_timer.start(min_spawn_break)


func _on_timer_timeout():
	for e in enemy_num:
		var rand_pos: Vector2i
		while (1):
			rand_pos = Vector2i(randi_range(0, _map_used_rect_size.x - 1), randi_range(0, _map_used_rect_size.y - 1))
			if _map.get_cell_tile_data(rand_pos).get_collision_polygons_count(0) == 0:
				break
		var slime: Entity = enemy.instantiate()
		print(16 * Vector2(rand_pos))
		slime.global_position = 16 * Vector2(rand_pos)
		add_child(slime)
	_wave_num += 1
	if _wave_num == max_waves:
		_timer.stop()
