extends CharacterBody2D

##################################################
const MOVING_SPEED = 300.0

var animated_sprite_node: AnimatedSprite2D
var collision_shape_node: CollisionShape2D
var damaged_timer_node: Timer
var unstuck_timer_node: Timer

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	collision_shape_node = $CollisionShape2D
	damaged_timer_node = $DamagedTimer
	unstuck_timer_node = $UnstuckTimer
	
	damaged_timer_node.wait_time = 0.25
	damaged_timer_node.connect("timeout", Callable(self, "_on_damaged_timer_timeout"))
	unstuck_timer_node.wait_time = 0.25
	unstuck_timer_node.connect("timeout", Callable(self, "_on_unstuck_timer_timeout"))
	
	add_to_group("Player")

##################################################
func _physics_process(delta: float) -> void:
	if GM.get_is_game_over():
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_direction: float = Input.get_axis("ui_left", "ui_right")
	if input_direction:
		velocity.x = input_direction * MOVING_SPEED
		animated_sprite_node.play("run")
		
		if input_direction > 0.0:
			animated_sprite_node.flip_h = false
		elif input_direction < 0.0:
			animated_sprite_node.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)
		animated_sprite_node.play("idle")

	move_and_slide()

##################################################
func _process(delta: float) -> void:
	if GM.get_player_life() <= 0 or global_position.y >= 640.0:
		GM.set_is_game_over(true)
	
	if Input.is_action_just_pressed("ui_accept"):
		if GM.get_is_game_over():
			GM.set_is_game_over(false)
			global_position = Vector2(180.0, 400.0)
			velocity = Vector2.ZERO
			SB.reset_game_signal()
			GM.set_game_score(0)
			GM.set_player_life(12)

##################################################
func apply_bounce(force_value: float) -> void:
	velocity.y = force_value

##################################################
func force_unstuck() -> void:
	if unstuck_timer_node.is_stopped():
		collision_shape_node.set_deferred("disabled", true)
		unstuck_timer_node.start()
		animated_sprite_node.modulate = Color.RED

##################################################
func damaged() -> void:
	if unstuck_timer_node.is_stopped():
		damaged_timer_node.start()
		animated_sprite_node.modulate = Color.RED

##################################################
func _on_damaged_timer_timeout() -> void:
	unstuck_timer_node.stop()
	animated_sprite_node.modulate = Color.WHITE
	collision_shape_node.disabled = false

##################################################
func _on_unstuck_timer_timeout() -> void:
	unstuck_timer_node.stop()
	collision_shape_node.disabled = false
	animated_sprite_node.modulate = Color.WHITE
