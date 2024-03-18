extends Resource

class_name Spell

@export var Name : String

enum SpellType {
	ATTACK,
	BLOCK,
	CURE,
	DEFLECT
}

@export var Type : SpellType
@export var Speed : float
