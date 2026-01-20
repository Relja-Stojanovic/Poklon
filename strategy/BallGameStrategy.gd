class_name BallGameStrategy extends GameStrategy

func gen_preview_element() -> int:
	return randi() % 7 + Element.BALL_RED

func check(pos: Vector2i, data: GameData, x: int, y: int, array: Array[Vector2i]) -> void:
	var element: int = data.elements[pos]
	var i: Vector2i = pos
	i.x += x
	i.y += y
	while GameService.valid_pos(data, i):
		if data.is_empty(i):
			return
		if data.elements[i] != element:
			return
		array.append(i)
		i.x += x
		i.y += y

func execute_match(data: GameData, pos: Vector2i) -> bool:
	var h: Array[Vector2i] = []
	var v: Array[Vector2i] = []
	var d1: Array[Vector2i] = []
	var d2: Array[Vector2i] = []
	check(pos, data, 1, 0, h)
	check(pos, data, -1, 0, h)
	check(pos, data, 0, 1, v)
	check(pos, data, 0, -1, v)
	check(pos, data, 1, 1, d1)
	check(pos, data, -1, -1, d1)
	check(pos, data, 1, -1, d2)
	check(pos, data, -1, 1, d2)
	var f: Array[Vector2i] = []
	if h.size() >= 4:
		f.append_array(h)
	if v.size() >= 4:
		f.append_array(v)
	if d1.size() >= 4:
		f.append_array(d1)
	if d2.size() >= 4:
		f.append_array(d2)
	
	if not f.is_empty():
		f.append(pos)
		#TODO: Make this more readable
		Chat.info_ball(data.elements[pos], f.size())
		for cell in f:
			data.remove_element(cell)
		var score: int = f.size() * 10
		data.add_score(score)
		return true
	return false
