extends "res://pitfall.gd"

func _ready():
	time_impact = -10
	var x_multiply = 1
	if (rand_range(0.2,100) > 50.0):
		x_multiply = -1
		
	var y_multiply = 1
	if (rand_range(0.2,100) > 50.0):
		y_multiply = -1

	velocity.x = rand_range(0.2,100) * x_multiply
	velocity.y = rand_range(0.2,100) * y_multiply
	speed = rand_range(0.2,5)
	sfx_collided_name = "player_collide_birdie"
	
	._ready()

func _on_pitfall_area_entered(area):
	._on_pitfall_area_entered(area)

func _process(delta):		
	._process(delta)

