extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_child_positions():
	var childs = (self as Node).get_children()
	var child_positions = []
	
	for child in childs:
		child_positions.append((child as Node2D).position/95)
		
	return child_positions
