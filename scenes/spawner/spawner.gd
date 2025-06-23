extends Node2D

##################################################
const PLATFORM_NORMAL: PackedScene = \
preload("res://scenes/platforms/normal/platform_normal.tscn")
const PLATFORM_SMASHED: PackedScene = \
preload("res://scenes/platforms/smashed/platform_smashed.tscn")
const PLATFORM_SPINNING: PackedScene = \
preload("res://scenes/platforms/spinning/platform_spinning.tscn")
const PLATFORM_SPRING: PackedScene = \
preload("res://scenes/platforms/spring/platform_spring.tscn")
const PLATFORM_POINTED: PackedScene = \
preload("res://scenes/platforms/pointed/platform_pointed.tscn")

const SCREEN_SIZE: Vector2 = Vector2(360.0, 640.0)
const SCREEN_OFFSET: float = 40.0
const PLATFORM_HALF_WIDTH: float = 64.0

var spawn_timer_node: Timer

##################################################
func _ready() -> void:
	spawn_timer_node = $SpawnTimer
	spawn_timer_node.wait_time = 1.0
	spawn_timer_node.one_shot = false
	spawn_timer_node.start()
	spawn_timer_node.connect("timeout", Callable(self, "_on_spawn_timer_node_timeout"))
	
	SB.connect("reset_game", Callable(self, "_on_reset_game"))

##################################################
func _on_spawn_timer_node_timeout() -> void:
	spawn_timer_node.start()
	
	if not GM.get_is_game_over():
		_spawn_platform()

##################################################
func _spawn_platform() -> void:
	var platform_random = randi() % 5
	var platform_normal_instance: StaticBody2D
	match platform_random:
		0:
			platform_normal_instance = PLATFORM_NORMAL.instantiate()
		1:
			platform_normal_instance = PLATFORM_SMASHED.instantiate()
		2:
			platform_normal_instance = PLATFORM_SPINNING.instantiate()
		3:
			platform_normal_instance = PLATFORM_SPRING.instantiate()
		4:
			platform_normal_instance = PLATFORM_POINTED.instantiate()
	
	add_child(platform_normal_instance)
	
	platform_normal_instance.global_position = \
	Vector2(randf_range(64.0, SCREEN_SIZE.x - PLATFORM_HALF_WIDTH), \
	SCREEN_SIZE.y + SCREEN_OFFSET)
	
	GM.set_game_score(GM.get_game_score() + 1)

##################################################
func _on_reset_game() -> void:
	for child in get_children():
		if child != spawn_timer_node:
			child.queue_free()
	spawn_timer_node.start()
	
	var platform_normal_instance = PLATFORM_NORMAL.instantiate()
	platform_normal_instance.global_position = Vector2(180.0, 480.0)
	add_child(platform_normal_instance)
