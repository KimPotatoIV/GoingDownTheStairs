extends StaticBody2D

##################################################
const MOVING_SPEED = 100.0

var area_node: Area2D

##################################################
func _ready() -> void:
	area_node = $Area2D
	
	area_node.connect("body_entered", Callable(self, "_on_body_entered"))

##################################################
func _physics_process(delta: float) -> void:
	if not GM.get_is_game_over():
		position.y -= MOVING_SPEED * delta
	
	if position.y < -100.0:
		queue_free()

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GM.set_player_life(GM.get_player_life() + 1)
		SM.play_landing_sound()
