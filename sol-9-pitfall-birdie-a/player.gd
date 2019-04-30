extends Area2D

onready var sprite = get_node("sprite")
onready var trail = get_node("trail")
onready var active_hair = get_node("active_hair")

var screensize
var extents
var speed = 400
var vel = Vector2()

func _ready():
	active_hair.visible = false
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	position = screensize / 2
		
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	vel = input.normalized() * speed
	if (vel.length() > 0):
		sprite.flip_h = vel.x < 0
		sprite.play()
		active_hair.flip_h = vel.x < 0
		trail.emitting = true
	else:
		sprite.stop()
		trail.emitting = false
	var pos = position + ( vel * delta )
	pos.x = clamp(pos.x, extents.x, screensize.x - extents.x)
	pos.y = clamp(pos.y, extents.y, screensize.y - extents.y)
	
	position = pos
	
func update_active_hair(texture):
	active_hair.texture = texture
	active_hair.visible = true
