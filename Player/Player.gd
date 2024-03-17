extends CharacterBody3D

var word: String
var wordlist: Array[String]
var trie : TrieNode
var curr: TrieNode
var up: String
var right: String
var down: String
var left: String
var lastMove: String

var characters = 'abcdefghijklmnopqrstuvwxyz'

signal update_up
signal update_right
signal update_down
signal update_left

@export var spellbook: Array[Spell]

func _ready():
	trie = TrieNode.new("")
	for i in spellbook:
		wordlist.append(i.Name)
	create_tree()
	trie.print_next()
	start_attack()
	print("")
	print_directions()
	
func create_tree():
	#print("Creating Tree")
	for i in range(spellbook.size()):
		curr = trie
		#trie.print_next()
		#print("i is " + str(i))
		for j in range(0,spellbook[i].Name.length()):
			if curr.contains(spellbook[i].Name[j]):
				curr = curr.next_of(spellbook[i].Name[j])
				continue
			else:
				#print("Appending new TrieNode for " + spellbook[i].Name[j])
				curr.Next.append(TrieNode.new(spellbook[i].Name[j]))
				curr = curr.next_of(spellbook[i].Name[j])
			spellbook[i].Name[j]
		#print(spellbook[i].Name)

func start_attack():
	curr = trie
	var possible = curr.next_letters()
	
	up = possible.pop_at(randi() % possible.size())
	right = possible.pop_at(randi() % possible.size())
	down = possible.pop_at(randi() % possible.size())
	left = possible.pop_at(randi() % possible.size())
		
func next_attack():
	pass
	
func attack(attack: Spell):
	print("Attacking!: " + attack.Name)
	
func fail_attack():
	print("failed to find a word!!!")
	
func print_directions():
	print("")
	print(word)
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
			fail_attack()
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

		print_directions()
		if(wordlist.find(word) != -1):
			attack(spellbook[wordlist.find(word)])
		pass
	if(event.is_action_pressed("right")):
		if lastMove == "right":
			return
		lastMove = "right"
		if curr.next_letters().size() == 0:
			fail_attack()
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

		print_directions()
		if(wordlist.find(word) != -1):
			attack(spellbook[wordlist.find(word)])
		pass
	if(event.is_action_pressed("down")):
		if lastMove == "down":
			return
		lastMove = "down"
		if curr.next_letters().size() == 0:
			fail_attack()
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

		print_directions()
		if(wordlist.find(word) != -1):
			attack(spellbook[wordlist.find(word)])
		pass
	if(event.is_action_pressed("left")):
		if lastMove == "left":
			return
		lastMove = "left"
		if curr.next_letters().size() == 0:
			fail_attack()
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

		print_directions()
		if(wordlist.find(word) != -1):
			attack(spellbook[wordlist.find(word)])
		pass	
	pass
