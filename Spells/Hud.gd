extends Control

class_name Hud

@onready var playerHealth = %Health
@onready var enemyHealth = %EnemyHealth
@onready var currentWord = %"Current Word"
@onready var upButton = %Up
@onready var rightButton = %Right
@onready var downButton = %Down
@onready var leftButton = %Left
@onready var indicator = %Indicator

var blinkcount: int
var blinktimer: float

func _ready():
	indicator.hide()
	blinkcount = 3
	blinktimer = 0.5
	pass

func _on_update_player_health(new_health:int) -> void:
	playerHealth.text = str(new_health)

func _on_update_enemy_health(new_health: int) -> void:
	enemyHealth.text = str(new_health)
	
func _on_update_up_button(letter: String)-> void:
	upButton.text = letter
	
func _on_update_right_button(letter: String) -> void:
	rightButton.text = letter

func _on_update_down_button(letter: String) -> void:
	downButton.text = letter
	
func _on_update_left_button(letter: String) -> void:
	leftButton.text = letter

func _on_update_word(word: String) -> void:
	currentWord.text = word

func _on_successful_attack(spell: Spell) -> void:
	indicator.texture = ResourceLoader.load("res://assets/Success.png")
	blink_indicator()
	pass
	
func _on_failed_attack(word: String) -> void:
	indicator.texture = ResourceLoader.load("res://assets/Fail.png")
	blink_indicator()
	pass
	
func blink_indicator():
	for i in range(0,blinkcount):
		indicator.show()
		await get_tree().create_timer(blinktimer).timeout
		indicator.hide()
		await get_tree().create_timer(blinktimer).timeout

