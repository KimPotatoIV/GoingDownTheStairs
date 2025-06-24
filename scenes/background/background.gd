extends Node2D

##################################################
var parallax_node: Parallax2D

##################################################
func _ready() -> void:
	parallax_node = $Parallax2D
	parallax_node.repeat_size = Vector2(0.0, 640.0)

##################################################
func _process(delta: float) -> void:
	if not GM.get_is_game_over():
		parallax_node.autoscroll = Vector2(0.0, 100.0)
	else:
		parallax_node.autoscroll = Vector2(0.0, 0.0)
