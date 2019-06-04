Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for 10 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2b
###		Icon that moves around haphazardly

Modify the pitfall scene
1. Open the pitfall.gd script
2. Add
export (int) var seconds_on_screen = 10

export (Vector2) var velocity = Vector2() # new line
export (int) var speed = 0 # new line

func _process(delta):  # new function
	var pos = position + ( velocity * speed * delta )
	if ((pos.x > screensize.x) or 
	   (pos.x < 0) or
	   (pos.y > screensize.y) or
	   (pos.y < 0)):
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
	else:	
		position = pos
		
3. Save and run - what happens?   Why?
4. How can we cause the birdie to move?



5. Open the birdie scene
	a. On the Inspector, make the following changes
	b. Script variables
		i.   Velocity.x = 50
		ii.  Velocity.y = 100
		iii. Speed = 2
6. How will the birdie move? Down and to right ( faster down than right )
7. Save and run - were you right?

REFACTORING next - going to learn more about inheritance!

8. How can we make this more random?
9. Go to the scene navigator for birdie.tscn
	a. Right click on birdie and choose: clear script
	b. Right click birdie and choose: attach script
		i.    Inherits: pitfall.gd
		ii.   Create
		iii.  Check to make sure your script variables in the Inspector for Time Impact, Velocity, and Speed are set
10. Save and run the scene - does the birdie still work? NO  Does it still decrease your time? NO


11. We need to modify the new birdie.gd script to say that it wants the behaviour from the pitfall.gd script it inheriting
12. Open the birdie.gd script
  a. Replace all but the extends... line with
func _ready():
	._ready()

func _on_pitfall_area_entered(area):
	._on_pitfall_area_entered(area)

func _process(delta):		
	._process(delta)
13. Talk about what the dot means and inheritence
14. Save and run.  Is is working the way it was before?


15. Now, back to the goal of randomizing the bird movement and speed...
	a. Modify the birdie.gd
func _ready():
	velocity.x = rand_range(0,100) # new line
	velocity.y = rand_range(0,100) # new line
	speed = rand_range(0,5)        # new line
	._ready()
16. Notice anything about the movement? It is always down and to the right.
17. How can we change that?


18. Allow all 4 directions of random movement
	a. Modify the birdie.gd
func _ready():
	# new lines begin
	time_impact = -10  # NOTE we no longer depend on the Inspector script variables now
	var x_multiply = 1					
	if (rand_range(0,100) > 50.0):
		x_multiply = -1
		
	var y_multiply = 1
	if (rand_range(0,100) > 50.0):
		y_multiply = -1

	# new lines end

	velocity.x = rand_range(0,100) * x_multiply  # modified line
	velocity.y = rand_range(0,100) * y_multiply  # modified line
	speed = rand_range(0,5)
	._ready()
19. Save and run
20. Is it working as expected? Should be yes

################# bth here 5.15.2019 ##################

21. What happens at game over? The birdies don't go away
  
22. Modify the main.gd script
...
var level = 1
var score = 0
var game_over = false  # new line
...
func handle_pitfalls():
	if !game_over: # new line and then have to indent all lines below
		if level > 1:
			if pitfall_container.get_child_count() == 0:
...
func _on_game_timer_timeout():
	game_over = true  # new line
	$background_music.stop()
	$go_sfx.play()	
...
23. Do the pitfalls stop spawning? YES
24. What happens to the birdie that was on the screen when game over happens? It finishes going off the screen. 
  
  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	gfx 	http://clipart-library.com/bird-animation.html
			https://jmsliu.com/products/sprite-sheet-decomposer/

