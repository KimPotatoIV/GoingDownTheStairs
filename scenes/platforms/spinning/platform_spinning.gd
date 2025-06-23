extends StaticBody2D

##################################################
const MOVING_SPEED = 100.0
const PUSH_SPEED = 100.0

var animated_sprite_node: AnimatedSprite2D
var area_node: Area2D

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	area_node = $Area2D
	
	area_node.connect("body_entered", Callable(self, "_on_body_entered"))
	
	var random_direction: int = randi() % 2
	if random_direction == 0:
		constant_linear_velocity = Vector2(PUSH_SPEED, 0.0)
		animated_sprite_node.flip_h = true
	else:
		constant_linear_velocity = Vector2(-PUSH_SPEED, 0.0)

##################################################
func _physics_process(delta: float) -> void:
	if not GM.get_is_game_over():
		position.y -= MOVING_SPEED * delta
	
	if position.y < -100.0:
		queue_free()

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SM.play_landing_sound()
		GM.set_player_life(GM.get_player_life() + 1)
