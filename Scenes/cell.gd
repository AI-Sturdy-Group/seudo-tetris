extends Node2D

var DEFAULT_COLOR = Color(1, 1, 1, 1)
var DEFAULT_HOVERED_COLOR = Color(0.5,0.5,0.5,0.5)
var DEFAULT_PLACED_COLOR = Color(1, 0, 0, 1)
var DEFAULT_POSITIONED_AND_HOVERED_COLOR = Color(0.486275, 0.988235, 0, 1)

enum posible_states {
	default,
	positioned,
	hovered,
	positioned_and_hovered
}

var state_color = {
	posible_states.default: DEFAULT_COLOR,
	posible_states.positioned: DEFAULT_PLACED_COLOR,
	posible_states.hovered: DEFAULT_HOVERED_COLOR,
	posible_states.positioned_and_hovered: DEFAULT_POSITIONED_AND_HOVERED_COLOR
}

var current_state = posible_states.default

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_default():
	if current_state == posible_states.positioned:
		return
		
	if current_state == posible_states.positioned_and_hovered:
		on_positioned()
		return	
		
	current_state = posible_states.default
	_paint_cell_according_to_current_state()
	
func set_placed_color(color: Color):
	state_color[posible_states.positioned] = color

func on_positioned():
	if current_state == posible_states.hovered:
		current_state = posible_states.positioned_and_hovered
	else:
		current_state = posible_states.positioned
		
	_paint_cell_according_to_current_state()
	
func on_hovered():
	if current_state == posible_states.positioned:
		current_state = posible_states.positioned_and_hovered
	else:
		current_state = posible_states.hovered
		
	_paint_cell_according_to_current_state()
	
func _paint_cell_according_to_current_state():
	(self.get_child(0)).get_child(0).color = state_color[current_state]

func is_hovered():
	var is_hovered = current_state == posible_states.hovered or current_state == posible_states.positioned_and_hovered
	
	return is_hovered
	
func is_positioned():
	return current_state == posible_states.positioned or current_state == posible_states.positioned_and_hovered

func get_current_state():
	return current_state
