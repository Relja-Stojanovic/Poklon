class_name Highscore extends Resource

const LIMIT = 10

@export var names: Array[String] = ["Hendikep","-","-","-","-","-","-","-","-","-"]
@export var scores: Array[int] = [100, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func add_game(new_name: String, new_score: int) -> void:
	print(new_name, new_score)
	for i in range(LIMIT):
		if new_score > scores[i]:
			print("i:%s old:%s %s new:%s %s." % [i, names[i], scores[i], new_name, new_score])
			names.insert(i, new_name)
			scores.insert(i, new_score)
			names.pop_back()
			scores.pop_back()
			return
