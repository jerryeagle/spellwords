extends Node2D
## The Game class serves to connect the player, enemy, and hud objects.
##
##
##


class_name Game

@export var player : Player
@export var hud: Hud


func _ready():
	if !player.update_health.is_connected(hud._on_update_player_health):
		player.update_health.connect(hud._on_update_player_health)
	if !player.update_up.is_connected(hud._on_update_up_button):
		player.update_up.connect(hud._on_update_up_button)
	if !player.update_right.is_connected(hud._on_update_right_button):
		player.update_right.connect(hud._on_update_right_button)
	if !player.update_down.is_connected(hud._on_update_down_button):
		player.update_down.connect(hud._on_update_down_button)
	if !player.update_left.is_connected(hud._on_update_left_button):
		player.update_left.connect(hud._on_update_left_button)
	if !player.update_word.is_connected(hud._on_update_word):
		player.update_word.connect(hud._on_update_word)
	if !player.succesful_attack.is_connected(hud._on_successful_attack):
		player.succesful_attack.connect(hud._on_successful_attack)
	if !player.failed_attack.is_connected(hud._on_failed_attack):
		player.failed_attack.connect(hud._on_failed_attack)

func _on_update_health(health):
	pass
