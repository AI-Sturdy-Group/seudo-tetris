extends Node2D

var _board_objects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_createBoard()
	_createPlayer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _createBoard():
	print('createBoard')
	for j in range(5):			
		for i in range(9):
			var cellScene = preload("res://Scenes/cell.tscn")
			var cell_instance = cellScene.instantiate()
			var cloneNode = cell_instance as Node2D
			var new_node_x_position = 95*i
			var new_node_y_position = 95*j
			cloneNode.position.x = new_node_x_position
			cloneNode.position.y = new_node_y_position
			add_child(cloneNode)
			_board_objects.append(cloneNode)
		
	print(self.get_child_count());
	pass
	
func _createPlayer():
	print('createPlayer')
	var player_scene = preload("res://Scenes/player.tscn")
	var player_instance = player_scene.instantiate()
	var player_instance_node2d = player_instance as Node2D
	
	player_instance_node2d.position.x = 95*10+100
	player_instance_node2d.position.y = 300
	
	add_child(player_instance)
	

func _input(event):
	if event is InputEventMouseMotion:
		_handle_mouse_move(event.position)
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_handle_mouse_click(event.position)

func _handle_mouse_click(mouse_position: Vector2):
	var valid_placement = _can_object_be_placed(mouse_position)
	if valid_placement:
		_place_player_object()

func _handle_mouse_move(mouse_position: Vector2):
	var grid_objects = _board_objects
	
	_unhover_objects()
	
	var player_objects = (self as Node).get_child(45)._get_child_positions() 
	for player_object in player_objects:	
		var player_object_x_position = mouse_position.x + (player_object.x * 95)
		var player_object_y_position = mouse_position.y + (player_object.y * 95)
		var player_object_position: Vector2 = Vector2(player_object_x_position, player_object_y_position)
		
		var outside_board = _is_object_outside_board(player_object_position)	
		# if mouse outside board then return
		if outside_board:
			continue	

		var pointed_object_x_position = floor((player_object_x_position) / 95)
		var pointed_object_y_position = floor((player_object_y_position) / 95)
		
		var pointed_object = _get_board_object_from_coordinates(Vector2(pointed_object_x_position, pointed_object_y_position))
		
		if pointed_object:
			pointed_object.on_hovered()
			#_paint_grid_object(pointed_object, DEFAULT_HOVERED_COLOR)
			#_hovered_objects.append(pointed_object)

func _unhover_objects():
	var hovered_objects = _get_hovered_objects()
	
	for hovered_object in hovered_objects:
		hovered_object.on_default()

func _is_object_outside_board(object_position: Vector2):
	return 0 > object_position.x or object_position.x > 9 * 95 or 0 > object_position.y or object_position.y > 5*95

func _can_object_be_placed(mouse_position: Vector2):
	var valid_placement = true
	var player_objects = (self as Node).get_child(45)._get_child_positions()
	
	for player_object in player_objects:
		var player_object_x_position = mouse_position.x + (player_object.x * 95)
		var player_object_y_position = mouse_position.y + (player_object.y * 95)
		var player_object_position: Vector2 = Vector2(player_object_x_position, player_object_y_position)
		
		var pointed_object_x_position = floor((player_object_x_position) / 95)
		var pointed_object_y_position = floor((player_object_y_position) / 95)
		var pointed_object = Vector2(pointed_object_x_position, pointed_object_y_position)
		
		var board_object = _get_board_object_from_coordinates(pointed_object)
		
		valid_placement = (board_object != null) and (not board_object.is_positioned())
		
		if not valid_placement:
			break
		
	return valid_placement
	
func _get_board_object_from_coordinates(coordinates: Vector2):
	var pointed_object_index = coordinates.x + coordinates.y * 9
	if pointed_object_index < len(_board_objects):
		return _board_objects[pointed_object_index]
		
	return null
	
func _place_player_object():
	var hovered_objects = _get_hovered_objects()
	for hovered_object in hovered_objects:
		hovered_object.on_positioned()

func _get_hovered_objects():
	return _board_objects.filter(func (board_object): return board_object.is_hovered());
