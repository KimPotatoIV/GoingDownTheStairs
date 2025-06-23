extends CanvasLayer

##################################################
const LIFE_ON = preload("res://scenes/hud/life_on.png")
const LIFE_OFF = preload("res://scenes/hud/life_off.png")

var h_box_container_node: HBoxContainer
var start_game_label: Label
var game_score_label: Label

##################################################
func _ready() -> void:
	h_box_container_node = $MarginContainer/HBoxContainer
	start_game_label = $StartGameLabel
	game_score_label = $GameScoreLabel
	
	_update_life()

##################################################
func _process(delta: float) -> void:
	start_game_label.visible = GM.get_is_game_over()
	game_score_label.text = "SCORE: " + str(GM.get_game_score()).pad_zeros(4)
	
	_update_life()

##################################################
func _update_life() -> void:
	var current_life = GM.get_player_life()
	
	for i in range(GM.get_max_player_life()):
		var heart_node = h_box_container_node.get_child(i)
		
		if i < current_life:
			heart_node.texture = LIFE_ON
		else:
			heart_node.texture = LIFE_OFF
