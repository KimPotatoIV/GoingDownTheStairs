extends StaticBody2D

##################################################
const MOVING_SPEED = 100.0
const BOUNCE_FORCE = -400.0

var sprite_node: Sprite2D
var animated_sprite_node: AnimatedSprite2D
var area_node: Area2D

##################################################
func _ready() -> void:
	sprite_node = $Sprite2D
	animated_sprite_node = $AnimatedSprite2D
	area_node = $Area2D
	
	animated_sprite_node.visible = false
	animated_sprite_node.connect("animation_finished", Callable(self, "_on_animation_finished"))
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
		SM.play_spring_sound()
		if body.has_method("apply_bounce"):
			body.apply_bounce(BOUNCE_FORCE)
		
		sprite_node.visible = false
		animated_sprite_node.visible = true
		animated_sprite_node.play()
		
		GM.set_player_life(GM.get_player_life() + 1)

##################################################
func _on_animation_finished() -> void:
	animated_sprite_node.visible = false
	sprite_node.visible = true
