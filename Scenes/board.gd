extends Node2D

var _board_objects = []
var _positioned_objects = []
var _hovered_objects = []
var DEFAULT_COLOR = Color(1, 1, 1, 1)
var DEFAULT_HOVERED_COLOR = Color(0.5,0.5,0.5,0.5)
var DEFAULT_PLACED_COLOLR = Color(1, 0, 0, 1)
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
		_get_stepped_grid(event.position)

func _get_stepped_grid(mouse_position: Vector2):
	var grid_objects = _board_objects
	
	if len(_hovered_objects) > 0:
		_unhover_objects()
	
	var player_objects = (self as Node).get_child(45)._get_child_positions() 
	
	for player_object in player_objects:	
		var player_object_x_position = mouse_position.x + (player_object.x * 95)
		var player_object_y_position = mouse_position.y + (player_object.y * 95)
		
		var outside_board = player_object_x_position > 9 * 95 or player_object_y_position > 5*95	
		# if mouse outside board then return
		if outside_board:
			return	

		var pointed_object_x_position = floor((player_object_x_position) / 95)
		var pointed_object_y_position = floor((player_object_y_position) / 95)
		var pointed_object_index = pointed_object_x_position + pointed_object_y_position * 9
		if pointed_object_index <= len(grid_objects) - 1:
			_paint_grid_object(grid_objects[pointed_object_index], DEFAULT_HOVERED_COLOR)
			_hovered_objects.append(grid_objects[pointed_object_index])

func _unhover_objects():
	for hovered_object in _hovered_objects:
		_paint_grid_object(hovered_object, DEFAULT_COLOR) 

func _paint_grid_object(grid_object: Node, color: Color):
	(grid_object.get_child(0)).get_child(0).color = color
