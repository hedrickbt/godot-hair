Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for 10 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2c
###		Tweeting bird sound effect

You will need:
	art/sfx/spawn_birdie.wav

NOTE:
I modified the birdie.tscn to set the rand range from 0.2 to ... instead of 0 to ... as I saw a case where the birdie came on
the screen and did not move - of course!

Modify the pitfall scene
1. Open the pitfall.tscn scene
2. In the scene navigator under pitfall, add an AudioStreamPlayer called spawn_sfx
3. Save the scene

Modify the birdie scene
1. Open the birdie.tscn
2. Set the spawn_sfx object...
	a. Stream | Load | art/sfx/spawn_birdie.wav
	b. Volume DB: -8
	c. Playing: on
	d. Autoplay: on

3. Save and run	
4. When does the sound play? When the birdie first comes onto the screen
5. Does it play more than once? NO

How do we handle the birdie sound at game over...

6. Open the main.gd script and add a signal
...
var level = 1
var score = 0
var game_over = false

signal game_over_signal		# new line
...

7. In the main.gd script, emit the signal
...
func _on_game_timer_timeout():
	game_over = true
	emit_signal("game_over_signal", self.name) 			# new line
	$background_music.stop()
...

8. In the main.gd script connect the signal from the main to the birdie
...
func handle_pitfalls():
	if !game_over:
		if level > 1:
			if pitfall_container.get_child_count() == 0:
				var b = birdie.instance()
				b.connect("pitfall_collided",self,"_on_pitfall_collided")
				self.connect("game_over_signal",b,"_on_game_over")			# new line
				pitfall_container.add_child(b)
...

9. Modify the pitfall.gd to handle the signal
...
func _on_game_over(name):  		# new function
	$spawn_sfx.stop()
	
10. Save and Run.   Does the birdie sound stop now on game over? NO

Now that we have a game over handler on our pitfall, we could add some more cleanup so that the birdie doesn't hang around.

11.  Modify the pitfall.gd script
...
func _on_game_over(name):
	$spawn_sfx.stop()
	shape_owner_clear_shapes(get_shape_owners()[0])		# new line
	queue_free()										# new line
	
12. Save and Run.  Does the birdie disappear on game over?  YES


  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	sfx:	https://www.youtube.com/watch?v=PNQ5YTP-CUk

