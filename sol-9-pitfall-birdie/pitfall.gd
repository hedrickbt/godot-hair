extends Area2D

var sprite = null

export (int) var time_impact = 0
export (int) var score_impact = 0
export (int) var seconds_on_screen = 10

signal pitfall_collided
	
func _ready():
	sprite = $sprite
	sprite.play()
		
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name)
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
