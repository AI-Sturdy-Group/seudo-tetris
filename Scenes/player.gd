extends Node2D

var _name
var _color

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

func _assign_color(color: Color):
	_color = color

func get_color():
	return _color
