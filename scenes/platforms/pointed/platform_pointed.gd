extends StaticBody2D

##################################################
const MOVING_SPEED = 100.0
const DAMAGE: int = 4

var area_node: Area2D
var is_entered: bool = false

##################################################
func _ready() -> void:
	area_node = $Area2D
	
	area_node.connect("body_entered", Callable(self, "_on_body_entered"))

##################################################
func _process(delta: float) -> void:
	if is_entered:
		is_entered = false
		GM.set_player_life(GM.get_player_life() - DAMAGE)

##################################################
func _physics_process(delta: float) -> void:
	if not GM.get_is_game_over():
		position.y -= MOVING_SPEED * delta
	
	if position.y < -100.0:
		queue_free()

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_entered = true
		SM.play_damaged_sound()
		
		if body.has_method("damaged"):
			body.damaged()
