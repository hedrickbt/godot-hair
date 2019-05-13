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
	sprite = $sprite
	sprite.play()

		
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name, time_impact, score_impact)
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()

func _process(delta):		
	var pos = position + ( velocity * speed * delta )
	if ((pos.x > screensize.x) or 
	   (pos.x < 0) or
	   (pos.y > screensize.y) or
	   (pos.y < 0)):
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
	else:	
		position = pos

