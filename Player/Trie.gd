extends Resource

class_name TrieNode

var Letter : String
var Next : Array[TrieNode]

func _init(_letter : String):
	Letter = _letter
	Next = []

func next_letters():
	var retArr : Array[String]
	for i in Next:
		retArr.append(i.Letter)
	return retArr

func contains(search : String):
	if(Next.size() == 0):
		return false
	var retArr : Array[String]
	for i in Next:
		if search == i.Letter:
			return true
	return false
	
func next_of(search: String):
	if(Next.size() == 0):
		return false
	var retArr : Array[String]
	for i in Next:
		if search == i.Letter:
			return i
	return TrieNode.new(search)

func print_next():
	if(Next.size() == 0):
		return
	var retArr : Array[String]
	for i in Next:
		print(i.Letter)


