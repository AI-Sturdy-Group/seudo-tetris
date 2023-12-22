extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
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
	print('ready')
		
	print(self.get_child_count());
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
