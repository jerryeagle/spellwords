extends Control

class_name Hud

@onready var playerHealth = %Health
@onready var enemyHealth = %EnemyHealth
@onready var currentWord = %"Current Word"
@onready var upButton = %Up
@onready var rightButton = %Right
@onready var downButton = %Down
@onready var leftButton = %Left
@onready var upButtonRect = %UpRect
@onready var rightButtonRect = %RightRect
@onready var downButtonRect = %DownRect
@onready var leftButtonRect = %LeftRect
@onready var indicator = %Indicator
@onready var enemyIndicator = %EnemyIndicator
@onready var levelbackground = %LevelBackground
@onready var levellabel = %LevelLabel
@onready var player1happy = $"../Player1Happy"
@onready var player1sad = $"../Player1Sad"
@onready var player2happy = $"../Player2Happy"
@onready var player2sad = $"../Player2Sad"
@onready var deflect = $"../Deflect"
@onready var tutorialtext = $ColorRect/tutorialtext


var blinkcount: int
var blinktimer: float

signal ready_for_attack()
signal deal_damage(int)
signal take_damage(int)
signal get_enemy_health()
signal get_player_health()
signal tell_player_next_level()

signal ready_for_enemy_attack()

func _ready():
	levelbackground.show()
	levellabel.hide()
	indicator.hide()
	enemyIndicator.hide()
	tutorialtext.show()
	await get_tree().create_timer(7).timeout
	tutorialtext.hide()
	levelbackground.hide()
	indicator.hide()
	enemyIndicator.hide()
	blinkcount = 4
	blinktimer = 0.33
	_on_next_level(1)



func _on_update_player_health(new_health:int) -> void:
	if new_health < 0:
		levelbackground.show()
		levellabel.text = "You lose!"
		levellabel.show()
		await get_tree().create_timer(3).timeout
		levellabel.text = "Thx4Playing"
		await get_tree().create_timer(9999999).timeout
		return
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
	
func _on_select_up() -> void:
	deflect.play()
	reset_buttons()
	upButtonRect.set_color(Color(255,0,0,255))
	
func _on_select_right() -> void:
	deflect.play()
	reset_buttons()
	rightButtonRect.set_color(Color(255,0,0,255))
	
func _on_select_down() -> void:
	deflect.play()
	reset_buttons()
	downButtonRect.set_color(Color(255,0,0,255))
	
func _on_select_left() -> void:
	deflect.play()
	reset_buttons()
	leftButtonRect.set_color(Color(255,0,0,255))

func reset_buttons() -> void:
	upButtonRect.set_color(Color(255,255,255,255))
	rightButtonRect.set_color(Color(255,255,255,255))
	downButtonRect.set_color(Color(255,255,255,255))
	leftButtonRect.set_color(Color(255,255,255,255))


func _on_successful_attack(spell: Spell) -> void:
	player1happy.play()
	indicator.texture = ResourceLoader.load("res://assets/Success.png")
	deal_damage.emit(spell.Name.length() * 3)
	blink_indicator()
	pass
	
func _on_failed_attack(word: String) -> void:
	player1sad.play()
	indicator.texture = ResourceLoader.load("res://assets/Fail.png")
	take_damage.emit(5)
	blink_indicator()
	pass

func _on_successful_enemy_attack(spell: Spell) -> void:
	player2happy.play()
	_on_update_word(spell.Name)
	enemyIndicator.texture = ResourceLoader.load("res://assets/Success.png")
	take_damage.emit(spell.Name.length() * 3)
	blink_enemy_indicator()
	
func _on_failed_enemy_attack() -> void:
	player2sad.play()
	_on_update_word("?????")
	enemyIndicator.texture = ResourceLoader.load("res://assets/Fail.png")
	deal_damage.emit(5)
	blink_enemy_indicator()

func blink_indicator():
	for i in range(0,blinkcount):
		indicator.show()
		await get_tree().create_timer(blinktimer).timeout
		indicator.hide()
		await get_tree().create_timer(blinktimer).timeout	
	ready_for_enemy_attack.emit()

func blink_enemy_indicator():
	for i in range(0,blinkcount):
		enemyIndicator.show()
		await get_tree().create_timer(blinktimer).timeout
		enemyIndicator.hide()
		await get_tree().create_timer(blinktimer).timeout
	ready_for_attack.emit()

func _on_next_level(level: int):
	print("level:" + str(level))
	levelbackground.show()
	levellabel.text = "Level " + str(level)
	levellabel.show()
	await get_tree().create_timer(2.55).timeout
	levelbackground.hide()
	levellabel.hide()
	tell_player_next_level.emit()


	
	
