extends Node2D
## The Game class serves to connect the player, enemy, and hud objects.
##
##
##


class_name Game

@export var player : Player
@export var hud: Hud
@export var enemy : Enemy


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
	if !player.successful_attack.is_connected(hud._on_successful_attack):
		player.successful_attack.connect(hud._on_successful_attack)
	if !player.failed_attack.is_connected(hud._on_failed_attack):
		player.failed_attack.connect(hud._on_failed_attack)
	if !hud.ready_for_attack.is_connected(player.next_attack):
		hud.ready_for_attack.connect(player.next_attack)
	if !player.select_up.is_connected(hud._on_select_up):
		player.select_up.connect(hud._on_select_up)
	if !player.select_right.is_connected(hud._on_select_right):
		player.select_right.connect(hud._on_select_right)
	if !player.select_down.is_connected(hud._on_select_down):
		player.select_down.connect(hud._on_select_down)
	if !player.select_left.is_connected(hud._on_select_left):
		player.select_left.connect(hud._on_select_left)
	if !player.select_none.is_connected(hud.reset_buttons):
		player.select_none.connect(hud.reset_buttons)
	if !hud.ready_for_enemy_attack.is_connected(enemy._attack):
		hud.ready_for_enemy_attack.connect(enemy._attack)
	if !enemy.successful_enemy_attack.is_connected(hud._on_successful_enemy_attack):
		enemy.successful_enemy_attack.connect(hud._on_successful_enemy_attack)
	if !enemy.failed_enemy_attack.is_connected(hud._on_failed_enemy_attack):
		enemy.failed_enemy_attack.connect(hud._on_failed_enemy_attack)
	if !hud.take_damage.is_connected(player._take_damage):
		hud.take_damage.connect(player._take_damage) 
	if !hud.deal_damage.is_connected(enemy._take_damage):
		hud.deal_damage.connect(enemy._take_damage) 
	if !enemy.update_health.is_connected(hud._on_update_enemy_health):
		enemy.update_health.connect(hud._on_update_enemy_health) 
	if !enemy.next_level.is_connected(hud._on_next_level):
		enemy.next_level.connect(hud._on_next_level) 
	if !hud.tell_player_next_level.is_connected(player._on_next_level):
		hud.tell_player_next_level.connect(player._on_next_level) 

func _on_update_health(health):
	pass
