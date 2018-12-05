extends Area2D

var screensize
var speed = 400
var vel = Vector2()

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	vel = input.normalized() * speed
	var pos = position + ( vel * delta )
	
	position = pos