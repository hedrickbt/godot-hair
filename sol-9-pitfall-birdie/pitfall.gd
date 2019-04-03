extends Area2D

var sprite = null
var screensize
var extents

export (int) var time_impact = 0
export (int) var score_impact = 0
export (int) var seconds_on_screen = 10
export (Vector2) var velocity = Vector2()
export (int) var speed = 0

signal pitfall_collided
	
func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	velocity.x = rand_range(0,100)
	velocity.y = rand_range(0,100)
	sprite = $sprite
	sprite.play()

		
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name)
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()

func _process(delta):		
	var pos = position + ( velocity * speed * delta )
	print(position)
	print(velocity)
	print(speed)
	print(delta)
	pos.x = clamp(pos.x, extents.x, screensize.x - extents.x)
	pos.y = clamp(pos.y, extents.y, screensize.y - extents.y)
	
	position = pos

