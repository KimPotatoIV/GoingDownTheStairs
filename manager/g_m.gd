extends Node

##################################################
const MAX_PLAYER_LIFE: int = 12

var is_game_over: bool = true
var game_score: int = 0
var player_life: int = 12

##################################################
func get_max_player_life() -> int:
	return MAX_PLAYER_LIFE

##################################################
func get_is_game_over() -> bool:
	return is_game_over

##################################################
func set_is_game_over(game_over_value: bool) -> void:
	is_game_over = game_over_value

##################################################
func get_game_score() -> int:
	return game_score

##################################################
func set_game_score(game_score_value: int) -> void:
	game_score = game_score_value

##################################################
func get_player_life() -> int:
	return player_life

##################################################
func set_player_life(life_value: int) -> void:
	player_life = clampi(life_value, 0, MAX_PLAYER_LIFE)
