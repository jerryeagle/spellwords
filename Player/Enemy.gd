extends CharacterBody2D

class_name Enemy

@onready var body = %Sprite2D
var _diff_setting : int
var spellbook : Array[Spell]
var health : int

signal successful_enemy_attack(spell: Spell)
signal failed_enemy_attack
signal update_health(health: int)
signal next_level(level: int)

func _ready():
	_diff_setting = 0
	health = _diff_setting * 15
	spellbook = []
	var spellResources = get_all_file_paths("res://Spells/")
	for i in spellResources:
		spellbook.append(load(i))	
	update_health.emit(health)
	level_up()


func _attack():
	if(randi() % 6 < _diff_setting):
		successful_enemy_attack.emit(spellbook[randi() % spellbook.size()])
	else:
		failed_enemy_attack.emit()
	
func _take_damage(damage: int):
	health -= damage
	if(health < 0):
		level_up()
		return
	update_health.emit(health)

func level_up():
	_diff_setting += 1
	health = _diff_setting * 15
	update_health.emit(health)
	next_level.emit(_diff_setting)
	
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
	
