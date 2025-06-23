extends StaticBody2D

##################################################
const MOVING_SPEED = 100.0
const DESTROY_DELAY: float = 1.0
const BLINK_INTERVAL: float = 0.1

var area_node: Area2D
var sprite_node: Sprite2D

var blink_timer: float = 0.0
var total_timer: float = 0.0
var blinking: bool = false

##################################################
func _ready() -> void:
	area_node = $Area2D
	sprite_node = $Sprite2D
	
	area_node.connect("body_entered", Callable(self, "_on_body_entered"))

##################################################
func _physics_process(delta: float) -> void:
	if not GM.get_is_game_over():
		position.y -= MOVING_SPEED * delta
	
	if position.y < -100.0:
		queue_free()

##################################################
func _process(delta: float) -> void:
	if blinking:
		blink_timer += delta
		total_timer += delta
	
	if blink_timer >= BLINK_INTERVAL:
		blink_timer = 0.0
		sprite_node.visible = not sprite_node.visible
	
	if total_timer >= DESTROY_DELAY:
		queue_free()

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SM.play_smashed_sound()
		if not blinking:
			blinking = true
		
		GM.set_player_life(GM.get_player_life() + 1)
