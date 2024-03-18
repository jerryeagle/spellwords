extends CharacterBody2D

class_name Player

var word: String
var wordlist: Array[String]
var health: int
var trie : TrieNode
var curr: TrieNode
var up: String
var right: String
var down: String
var left: String
var lastMove: String
var spellResources: Array[String]

var charup = load("res://assets/player1u.png") 
@onready var mysprite = $CollisionShape2D/Sprite

var no_control = false

var characters = 'abcdefghijklmnopqrstuvwxyz'

signal update_up(letter: String)
signal update_right(letter: String)
signal update_down(letter: String)
signal update_left(letter: String)
signal select_up()
signal select_right()
signal select_down()
signal select_left()
signal select_none()
signal update_health(health: int)
signal update_word(word: String)
signal successful_attack(spell: Spell)
signal failed_attack(spell: String)

var spellbook: Array[Spell]

func _ready():
	print("ready")
	health = 100
	spellbook = []
	spellResources = get_all_file_paths("res://Spells/")
	for i in spellResources:
		spellbook.append(load(i))

	trie = TrieNode.new("")
	for i in spellbook:
		wordlist.append(i.Name)
	create_tree()
	start_attack()
	_update_health()

	
func create_tree():
	for i in range(spellbook.size()):
		curr = trie
		for j in range(0,spellbook[i].Name.length()):
			if curr.contains(spellbook[i].Name[j]):
				curr = curr.next_of(spellbook[i].Name[j])
				continue
			else:
				curr.Next.append(TrieNode.new(spellbook[i].Name[j]))
				curr = curr.next_of(spellbook[i].Name[j])
			spellbook[i].Name[j]

func start_attack():
	select_none.emit()
	no_control = false
	curr = trie
	word = ""
	_update_word()
	select_none.emit()
	var possible = curr.next_letters()
	up = possible.pop_at(randi() % possible.size())
	right = possible.pop_at(randi() % possible.size())
	down = possible.pop_at(randi() % possible.size())
	left = possible.pop_at(randi() % possible.size())
	_update_buttons()

func _take_damage(damage : int):
	health -= damage
	if(health <= 0):
		no_control = true
	update_health.emit(health)
	
func _update_buttons():
	if lastMove != "up":
		emit_signal("update_up", up)

	if lastMove != "right":
		emit_signal("update_right", right)	

	if lastMove != "down":
		emit_signal("update_down", down)

	if lastMove != "left":
		emit_signal("update_left", left)

		
func _update_health():
	update_health.emit(health)

func _update_word():
	update_word.emit(word)

func next_attack():
	start_attack()
	pass
	
func _on_next_level():
	health = 100
	
func _attack(attack: Spell):
	no_control = true
	successful_attack.emit(attack)
	
func _fail_attack():
	no_control = true
	failed_attack.emit(word)

func _input(event):
	if(no_control == true):
		return
	if(event.is_action_pressed("up")):
		if lastMove == "up":
			return
		lastMove = "up"
		select_up.emit()
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(up)
		word = word + up
		var possible = curr.next_letters()

		if(possible.size() != 0):
			down = possible.pop_at(randi() % possible.size())
		else:
			down = characters[randi()% characters.length()]
		if(possible.size() != 0):
			left = possible.pop_at(randi() % possible.size())
		else:
			left = characters[randi()% characters.length()]
		if(possible.size() != 0):
			right = possible.pop_at(randi() % possible.size())
		else:
			right = characters[randi()% characters.length()]
		
	if(event.is_action_pressed("right")):
		if lastMove == "right":
			return
		lastMove = "right"
		select_right.emit()
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(right)
		word = word + right
		var possible = curr.next_letters()
		if(possible.size() != 0):
			up = possible.pop_at(randi() % possible.size())
		else:
			up = characters[randi()% characters.length()]
		if(possible.size() != 0):
			down = possible.pop_at(randi() % possible.size())
		else:
			down = characters[randi()% characters.length()]
		if(possible.size() != 0):
			left = possible.pop_at(randi() % possible.size())
		else:
			left = characters[randi()% characters.length()]
		
	if(event.is_action_pressed("down")):
		if lastMove == "down":
			return
		lastMove = "down"
		select_down.emit()
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(down)
		word = word + down
		var possible = curr.next_letters()
		if(possible.size() != 0):
			left = possible.pop_at(randi() % possible.size())
		else:
			left = characters[randi()% characters.length()]
		if(possible.size() != 0):
			right = possible.pop_at(randi() % possible.size())
		else:
			right = characters[randi()% characters.length()]
		if(possible.size() != 0):
			up = possible.pop_at(randi() % possible.size())
		else:
			up = characters[randi()% characters.length()]

		
	if(event.is_action_pressed("left")):
		if lastMove == "left":
			return
		lastMove = "left"
		select_left.emit()
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(left)
		word = word + left
		var possible = curr.next_letters()
		if(possible.size() != 0):
			right = possible.pop_at(randi() % possible.size())
		else:
			right = characters[randi()% characters.length()]
		if(possible.size() != 0):
			down = possible.pop_at(randi() % possible.size())
		else:
			down = characters[randi()% characters.length()]
		if(possible.size() != 0):
			up = possible.pop_at(randi() % possible.size())
		else:
			up = characters[randi()% characters.length()]

	if(wordlist.find(word) != -1):
		_attack(spellbook[wordlist.find(word)])
		
	_update_word()
	_update_buttons()	
	
	
func get_all_file_paths(path: String) -> Array[String]:  
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(path)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path + "/" + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_file_paths(file_path)  
		else:  
			file_paths.append(file_path)  
		file_name = dir.get_next()  
	return file_paths
	
