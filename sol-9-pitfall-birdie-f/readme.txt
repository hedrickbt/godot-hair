Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for at most 5 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2f
###		Visual effect when you run into the birdie

You will need
	art/gfx/explosion/explosion1.png
	art/gfx/explosion/explosion2.png
	art/gfx/explosion/explosion3.png
	art/gfx/explosion/explosion4.png
	art/gfx/explosion/explosion5.png
	art/gfx/explosion/explosionSmoke1.png
	art/gfx/explosion/explosionSmoke2.png
	art/gfx/explosion/explosionSmoke3.png
	art/gfx/explosion/explosionSmoke4.png
	art/gfx/explosion/explosionSmoke5.png
	
Create a new scene explosion.tscn to manage visual effect
1. Create a new scene
	a. Scene | New scene 
	b. Add AnimatedSprite node
	c. Change the new nodes name to explosion
	c. Save the scene: explosion.tscn
		i. Create a new folder under res:// called effects and place the new scene in there

2. Add the images to the sprite
	a. explosion | Inspector | Animated Sprite | Frames | [empty] | New Sprite Frames
	b. Click on the New Sprite Frames you just created
	c. Resource | Open Editor
	d. Add 2 animations - using + button on the left side of the editor
		i.  fire - 15 fps, drag related images from the /art/gfx/explosions folder explosion1-5
		ii. smoke - 15 fps, drag related images from the /art/gfx/explosions folder explosionSmoke1-5
	e. Save

3. Attach the explosion to our pitfall
	a. Open the pitfall.tscn scene
	b. On the scene, don't click the plus, click the chain (Instance a scene file as a node)
		i.  Choose the effects/explosion.tscn
		ii. Make sure it is just under the pitfall level in the tree - not under another node
	c. explosion | Inspector | Canvas Item | Visibility | Visible - uncheck on
		i. You can also do this by click the eyeball/bullseye to the right of the explosion node in the scene view
	d. Save
	
4. Add the code that will cause the effect to be displayed
	a. Open the pitfall.tscn
	b. Change the _on_pitfall_area_entered function to play the effect
#########################################################################################	
OLD:
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name)
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
NEW:
func _on_pitfall_area_entered(area):
	if area.name == "player":
		velocity = Vector2()
		sprite.hide()
		$explosion.show()
		$explosion.play("smoke")
#########################################################################################		
	c. Scene | explosion | Node (instead of Inspector tab) | AnimatedSprite | animation_finished() - dbl click
		i.   Path to node: ..
		ii.  Method on node: _on_explosion_animation_finished
		iii. Connect
	d. You now have a new function: func _on_explosion_animation_finished().  Use the following code
#########################################################################################		
func _on_explosion_animation_finished():
	emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name)
	shape_owner_clear_shapes(get_shape_owners()[0])
	queue_free()
#########################################################################################		
	

Time to test
1. Save and run
2. Do you see an explosion when the player runs into a birdie? YES
3. How would you use the other animation we added?  Change smoke to fire in the _on_pitfall_area_entered function


  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE:
	Explosion graphics from https://kenney.nl/assets/topdown-tanks-redux
	
NOTE: 
	Content help for this came from 
	sfx:	https://www.youtube.com/watch?v=PNQ5YTP-CUk

