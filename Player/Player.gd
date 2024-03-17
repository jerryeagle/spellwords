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

var no_control = false

var characters = 'abcdefghijklmnopqrstuvwxyz'

signal update_up(letter: String)
signal update_right(letter: String)
signal update_down(letter: String)
signal update_left(letter: String)
signal update_health(health: int)
signal update_word(word: String)
signal succesful_attack(spell: Spell)
signal failed_attack(spell: String)

@export var spellbook: Array[Spell]

func _ready():
	health = 100
	trie = TrieNode.new("")
	for i in spellbook:
		wordlist.append(i.Name)
	create_tree()
	trie.print_next()
	start_attack()
	print("")
	print_directions()
	health = 50
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
	curr = trie
	var possible = curr.next_letters()
	
	up = possible.pop_at(randi() % possible.size())
	right = possible.pop_at(randi() % possible.size())
	down = possible.pop_at(randi() % possible.size())
	left = possible.pop_at(randi() % possible.size())
	_update_buttons()
	
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
	print("emitting Health")
	update_health.emit(health)

func _update_word():
	update_word.emit(word)

func next_attack():
	pass
	
func _attack(attack: Spell):
	succesful_attack.emit(attack)
	
func _fail_attack():
	failed_attack.emit(word)
	
func print_directions():
	if lastMove != "up":
		print("up: " + up)
	if lastMove != "right":
		print("right: " + right)
	if lastMove != "down":
		print("down: " + down)
	if lastMove != "left":
		print("left: " + left)

func _input(event):
	if(event.is_action_pressed("up")):
		if lastMove == "up":
			return
		lastMove = "up"
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(up)
		word = word + up
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
			left = possible.pop_at(randi() % possible.size())
		else:
			left = characters[randi()% characters.length()]
		
	if(event.is_action_pressed("right")):
		if lastMove == "right":
			return
		lastMove = "right"
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
		if curr.next_letters().size() == 0:
			_fail_attack()
			return
		curr = curr.next_of(down)
		word = word + down
		var possible = curr.next_letters()
		if(possible.size() != 0):
			right = possible.pop_at(randi() % possible.size())
		else:
			right = characters[randi()% characters.length()]
		if(possible.size() != 0):
			up = possible.pop_at(randi() % possible.size())
		else:
			up = characters[randi()% characters.length()]
		if(possible.size() != 0):
			left = possible.pop_at(randi() % possible.size())
		else:
			left = characters[randi()% characters.length()]
		
	if(event.is_action_pressed("left")):
		if lastMove == "left":
			return
		lastMove = "left"
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
	
