extends StaticBody2D

##################################################
const DAMAGE: int = 5

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
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SM.play_damaged_sound()
		is_entered = true
		
		if body.has_method("force_unstuck"):
			body.force_unstuck()
