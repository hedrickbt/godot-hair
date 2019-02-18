Goals:
Change out our player for an animated sprite that "looks" like he is running and handles running left or right.

### Create the animation to the right
We will need
art:
	running_3.png
	running_3a.png
	
1. Open the player scene (player.tscn)
3. Rename the sprite node to sprite_old
4. Add a child node under player node of type AnimatedSprite
	a. Set the name to sprite
5. Add the animated frames
	a. In the scene tree, click on the new sprite node
	b. In the inspsector, click on the [empty] under the Frames attribute
	c. Choose New SpriteFrames
	d. Click where it used to say [empty] and now says SpriteFrames and then choose Edit
	e. In the Animation Frames editor, drag the art/running_3.png and art/running_3a.png files into the editor
	f. Leave the animation name "default"
	g. To see the animation, go back to the inspector and tick the playing attribute to set it to on.  
		i.  You can play around with frame rates here to see what looks good.
	h. Turn off the "playing" attribute
6. Delete the sprite_old
7. Update the positions and collision box
	a. If you have the sprite and collision locked, you will need to unlock them.
	b. Adjust the collision box (midpoint handles only)
8. Save the scene ( ctrl+s ) / Play the Game (F5) - Is he running? NOT YET

### Write the code to activate the running
1. In the player scene, edit the player script
extends Area2D
...
onready var sprite = get_node("sprite")
...
var screensize
...
func _process(delta):
...
	vel = input.normalized() * speed
	if (vel.length() > 0):
		sprite.play()
	else:
		sprite.stop()
	var pos = position + ( vel * delta )
...

2. Save the scene ( ctrl+s ) / Play the Game (F5) - Is he running? YEP.  Is there anything odd about the direction?

### Write the code to handle the running direction
1. Go back to the Animation Frames editor for the player|sprite
2. Is there anything we can do without adding new frames or animations to have him be able to look left?
	a. Not the Flip H and Flip V attributes
3. Open the script editor for player
....
func _process(delta):
...
	vel = input.normalized() * speed
	if (vel.length() > 0):
		sprite.flip_h = vel.x < 0  // new line!!
		sprite.play()
	else:
		sprite.stop()
	var pos = position + ( vel * delta )
...
4. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the running look better? YES.  Is there something we need to do at the game over?

### Write the code to stop running on game over
1. Edit the player script

func _on_game_timer_timeout():
	get_node("player/sprite").stop()  // new line!!
	get_node("player").set_process(false)
...
2. Save the scene ( ctrl+s ) / Play the Game (F5) - Does he stop running at game over? YES
							 
	
DONE!!

NOTE: Unable to write to file...
Click the stop button. Square button near the play scene button.
	
