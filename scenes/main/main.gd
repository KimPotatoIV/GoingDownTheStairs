extends Node2D

##################################################
const SHAKE_DELAY: float = 0.25
const SHAKE_INTENSITY: float = 4.0

var shake_camera_node: Camera2D

var player_life: int = GM.get_max_player_life()
var shake: bool = false
var shake_timer: float = 0.0

##################################################
func _ready() -> void:
	shake_camera_node = $ShakeCamera

##################################################
func _process(delta: float) -> void:
	if GM.get_player_life() < player_life:
		player_life = GM.get_player_life()
		shake = true
	else:
		player_life = GM.get_player_life()
	
	if shake:
		_shake_camera()
		
		shake_timer += delta
		if shake_timer >= SHAKE_DELAY:
			shake = false
			shake_timer = 0.0
			shake_camera_node.position = Vector2.ZERO

##################################################
func _shake_camera() -> void:
	var offset = \
	Vector2(randf_range(-SHAKE_INTENSITY, SHAKE_INTENSITY), \
	randf_range(-SHAKE_INTENSITY, SHAKE_INTENSITY))
	shake_camera_node.position = offset
