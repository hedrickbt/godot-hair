extends Area2D

var screensize
var extents
var speed = 400
var vel = Vector2()

func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	vel = input.normalized() * speed
	var pos = position + ( vel * delta )
	pos.x = clamp(pos.x, extents.x, screensize.x - extents.x)
	pos.y = clamp(pos.y, extents.y, screensize.y - extents.y)
	
	position = pos