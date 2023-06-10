extends Node2D

export (Color) var line_color = Color.red

var oldMousePosition = Vector2.ZERO
var flicker = false

func _ready():
	oldMousePosition = get_local_mouse_position()

func _process(_delta):
	flickerRender()
	update()
	
	if(isMouseOnScreen() == true):
		oldMousePosition = get_local_mouse_position()

# called by the update() function. Draws lines to a canvas layer
func _draw():
	var target: Vector2
	# evaluates the end point of the line based on if the mouse is in the screen margins or not 
	if(isMouseOnScreen() == true): target = get_local_mouse_position().snapped(Vector2.ONE)
	elif(isMouseOnScreen() == false): target = oldMousePosition.snapped(Vector2.ONE)
	
	# picks optimal function to draw the line
	if target.x == 0 || target.y == 0:
		draw_line(Vector2.ZERO, target, line_color)
	elif abs(target.x) > abs(target.y):
		_draw_horizontal_segments(target)
	else:
		_draw_vertical_segments(target)

func _draw_horizontal_segments(target: Vector2):
	var width = abs(target.x / target.y) * sign(target.x)

	var float_x = 0.0

	var sign_y = sign(target.y)
	for int_y in abs(target.y):
		# make y negative if required
		var y: int = int_y * sign_y
		# only convert to int when drawing
		var ax = int(float_x)
		var bx = int(float_x + width)

		var a = Vector2(ax, y)
		var b = Vector2(bx, y)
		draw_line(a, b, line_color)

		float_x += width

func _draw_vertical_segments(target: Vector2):
	var height = abs(target.y / target.x) * sign(target.y)

	var float_y = 0.0

	var sign_x = sign(target.x)
	for int_x in abs(target.x):
		# make x negative if required
		var x: int = int_x * sign_x
		# only convert to int when drawing
		var ay = int(float_y)
		var by = int(float_y + height)

		var a = Vector2(x, ay)
		var b = Vector2(x, by)
		draw_line(a, b, line_color)

		float_y += height

func isMouseOnScreen():
	if(get_global_mouse_position().x < 54 || get_global_mouse_position().x > 373):
		return false
	else: return true

func mouseMoved():
	if(get_local_mouse_position() != oldMousePosition): return true
	elif(get_local_mouse_position() == oldMousePosition): return false

func flickerRender():
	if(mouseMoved()): flicker = not flicker
	elif(not mouseMoved()): flicker = false
	
	if flicker == true: line_color = Color.transparent
	elif flicker == false: line_color = Color.red
