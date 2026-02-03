extends Node

# NOTES:
#
# var spawn_boundary: Vector2i = get_parent().get_used_rect().size
# e/s: e enemies spawned per s seconds
#
# Things that should be variable:
# The number of enemies to spawn: e
# How many seconds until next spawn: s
# Max number of waves until map cleared

func _ready():
	# Set timer for s seconds
	pass


func spawn_enemy():
	# For e amount of times:
	# Pick random point within spawn_boundary
	# Repeat until random tile selected is not a "wall" tile
	# Spawn enemy at this point
	pass
