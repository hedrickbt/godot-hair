Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for at most 5 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2d
###		Stays around for at most 5 seconds

Modify the pitfall scene
1. Open the pitfall.tscn scene

2. Add a variable to track when the pitfall first was created - why such a large initial value?  To avoid it going away by _process before _ready sets the value.
var sprite = null
var screensize
var extents
var time_started = 9223372036854775807  // new line

3. Modify the _ready function to initiaze the time_started variable
func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	sprite = $sprite
	sprite.play()
	time_started = OS.get_ticks_msec()  // new line

4. modify the _process function
func _process(delta):
	var set_position = true		 // new line
	var pos = position + ( velocity * speed * delta )
	if ((pos.x > screensize.x) or 
	   (pos.x < 0) or
	   (pos.y > screensize.y) or
	   (pos.y < 0)):
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
		set_position = false
	else: // redid this section - added lines
		if (seconds_on_screen	> 0):
			if (OS.get_ticks_msec() - time_started >= (seconds_on_screen * 1000)):
				shape_owner_clear_shapes(get_shape_owners()[0])
				queue_free()	
				set_position = false
	if set_position:  // new section
		position = pos	

5. Save the scene and run
6. Is the birdie only staying on the scene up to 5 seconds?  NO.  Why?  Have yet to set the value when spawning it.

Modify the main scene
1. Open the main.tscn
2. Tell the birdie how long to remain on the screen by modifying handle_pitfalls
func handle_pitfalls():
	if !game_over:
		if level > 1:
			if pitfall_container.get_child_count() == 0:
				var b = birdie.instance()
				b.connect("pitfall_collided",self,"_on_pitfall_collided")
				self.connect("game_over_signal",b,"_on_game_over")
				pitfall_container.add_child(b)
				b.position = Vector2(rand_range(0, screensize.x - 40),
									 rand_range(0, screensize.y - 40))
				b.seconds_on_screen = 5  // new line


3. Save and run	
4. Does the birdie only stay on the screen for 5 seconds? YES

  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	sfx:	https://www.youtube.com/watch?v=PNQ5YTP-CUk

