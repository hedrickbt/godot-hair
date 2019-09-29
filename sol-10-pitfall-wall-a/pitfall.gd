extends Area2D

var sprite = null
var screensize
var extents
var time_started = 9223372036854775807


export (int) var time_impact = 0
export (int) var score_impact = 0
export (int) var seconds_on_screen = 0
export (String) var sfx_collided_name = ""
export (bool) var collision_destroys = true

export (Vector2) var velocity = Vector2()
export (int) var speed = 0

signal pitfall_collided
signal pitfall_off_screen
	
func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	sprite = $sprite
	sprite.play()
	time_started = OS.get_ticks_msec()

		
func _on_pitfall_area_entered(area):
	if area.name == "player":
		velocity = Vector2()
		if self.collision_destroys:
			sprite.hide()
			$explosion.show()
			$explosion.play("smoke")
		else:
			emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name, collision_destroys)

func _process(delta):
	var set_position = true		
	var pos = position + ( velocity * speed * delta )
	if ((pos.x > screensize.x) or 
	   (pos.x < 0) or
	   (pos.y > screensize.y) or
	   (pos.y < 0)):
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
		set_position = false
		emit_signal("pitfall_off_screen", self.get_class(), self.name)
	else:
		if (seconds_on_screen	> 0):
			if (OS.get_ticks_msec() - time_started >= (seconds_on_screen * 1000)):
				shape_owner_clear_shapes(get_shape_owners()[0])
				queue_free()	
				set_position = false
				emit_signal("pitfall_off_screen", self.get_class(), self.name)
	if set_position:
		position = pos
		
func _on_game_over(name):
	$spawn_sfx.stop()
	shape_owner_clear_shapes(get_shape_owners()[0])
	queue_free()
	


func _on_explosion_animation_finished():
	emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name, collision_destroys)
	shape_owner_clear_shapes(get_shape_owners()[0])
	queue_free()

