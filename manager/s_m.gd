extends Node

##################################################
const BGM: AudioStream = preload("res://sounds/maou_bgm_8bit28.ogg")
const DAMAGED_SOUND: AudioStream = \
preload("res://sounds/maou_se_battle17.wav")
const LANDING_SOUND: AudioStream = \
preload("res://sounds/maou_se_battle07.wav")
const SMASHED_SOUND: AudioStream = \
preload("res://sounds/maou_se_sound23.wav")
const SPRING_SOUND: AudioStream = \
preload("res://sounds/maou_se_8bit03.wav")

var bgm_player: AudioStreamPlayer
var damaged_sound_player: AudioStreamPlayer
var landing_sound_player: AudioStreamPlayer
var smashed_sound_player: AudioStreamPlayer
var spring_sound_player: AudioStreamPlayer

##################################################
func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	bgm_player.stream = BGM
	bgm_player.volume_db = -10.0
	bgm_player.play()
	
	damaged_sound_player = AudioStreamPlayer.new()
	add_child(damaged_sound_player)
	damaged_sound_player.stream = DAMAGED_SOUND
	damaged_sound_player.volume_db = -10.0

	landing_sound_player = AudioStreamPlayer.new()
	add_child(landing_sound_player)
	landing_sound_player.stream = LANDING_SOUND
	landing_sound_player.volume_db = -10.0
	
	smashed_sound_player = AudioStreamPlayer.new()
	add_child(smashed_sound_player)
	smashed_sound_player.stream = SMASHED_SOUND
	smashed_sound_player.volume_db = -10.0
	
	spring_sound_player = AudioStreamPlayer.new()
	add_child(spring_sound_player)
	spring_sound_player.stream = SPRING_SOUND
	spring_sound_player.volume_db = -10.0

##################################################
func play_damaged_sound() -> void:
	damaged_sound_player.play()

##################################################
func play_landing_sound() -> void:
	landing_sound_player.play()

##################################################
func play_smashed_sound() -> void:
	smashed_sound_player.play()

##################################################
func play_spring_sound() -> void:
	spring_sound_player.play()
