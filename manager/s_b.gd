extends Node

##################################################
signal reset_game

##################################################
func reset_game_signal() -> void:
	emit_signal("reset_game")
