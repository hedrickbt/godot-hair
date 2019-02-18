Goals:
1. Improve the game font
2. Add a "smoke" effect to the player while running around



### Updating the font
We will need:
	art/font/Xolonium-Bold.ttf
	
1. Open the main scene (main.tscn)
2. Under main/hud, update the following labels: score_label, time_label, go_lable
	a. Click on the font in the scene tree
	b. In the inspector under Custom Fonts | Font, click on arrow to the right of [empty]
	c. Choose New DynamicFont
	d. Under the Font attribute, click on Dynamic Font.  Choose Font | Font Data | [empty] | Load
	e. Pick art/font/Xolonium-Bold.ttf
	f. Set the Font | Settings | Size to 64  ( 128 looks better for go_label )
	g. Change the Rect | Scale to x:1 and y:1 from x:4 and y:4
4. Save the scene ( ctrl+s ) / Play the Game (F5) - Do the fonts look better: YES


### Adding the player smoke effect
1. Open the player scene (player.tscn)
2. Add a child node to the player for Particles2D
	a. Name: trail
	b. Emitting: On
	c. Amount: 10
	d. Time | Speed Scale: 2
	e. Textures | Texture: art/smoke_ring.png
	f. Canvas Item | Visibility | Show Behind Parent: Check
	g. Process Material | New ParticalsMaterial
	h. Click on the new ParticlesMaterial
		i.    Gravity | x: 0, y: 0, z: 0
		ii.   Scale | Scale Curve | New Curve Texture. Click on the Curve.  
		iii.  Set scale from 25% on the left to 0% on the right
		iv.   Color | Color Ramp | New GradientTexture. 
		v.    Click on the GradientTexture | Gradient | Gradient | New Gradient
		vi.   Click on the newly create Gradient	
		vii.  Start alpha value: 195  (dbl-click left tall/skinny box)
		viio. End alpha value: 0  (dbl-click right tall/skinny box)
	i. Drawing | Local Coords On: Uncheck
	j. Node2D | Transform | Position | Y : 30
3. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the trail show?  YES.  Any issues when stopped: YES

### Fix the issue of the trail showing when player not moving.
1. Open the player scene (player.tscn)
2. Edit the player script
...
onready var sprite = get_node("sprite")
onready var trail = get_node("trail") // new line

var screensize
...
func _process(delta):
	...
	if (vel.length() > 0):
		...
		sprite.play()  
		trail.emitting = true // new line
	else:
		sprite.stop()
		trail.emitting = false // new line
	var pos = position + ( vel * delta )
	...
...
3. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the trail stop when the player stops? YES.  Are there any 
other cases where it doesn't?  YES - game end


			
### Fix the issue of the trail showing at game over
Where would you go to add the fix?
1. Open the main scene (main.tscn)
2. Edit the main script
func _on_game_timer_timeout():
	...
	get_node("player/sprite").stop()
	get_node("player/trail").emitting = false  // new line
	get_node("player").set_process(false)
	...
...

3. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the trail stop at game over? YES

DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	godot:	https://www.youtube.com/watch?v=L-GVq8Lvllo&list=PLsk-HSGFjnaFutTDzgik2KMRl6W1JxFgD&index=6
	godot: 	https://docs.godotengine.org/en/3.0/getting_started/step_by_step/your_first_game.html
	sfx:	https://www.youtube.com/watch?v=JY6kfsqpReY
	music:	https://opengameart.org/
	font: 	https://www.dafont.com/xolonium.font

