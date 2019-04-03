Goals:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. icon that moves around haphazardly - take time away 
	b. Tweeting bird sound effect
	c. Stays around for 10 seconds



### Adding the "super scene" for pitfalls
1. Create a new scene
	a. Add a Area2D node
	b. Name it: pitfall
	c. Save the scene as pitfall.tscn
2. Add child nodes to pitfall	
	a. AnimatedSprite: sprite
	b. CollisionShape2D: collision
	c. Don't worry about assign a texture or a collision area
3. Attach script to pitfall - accept defaults
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

		
4. Select the pitfall node		
	a. Go to the Inspector/Node an click on the Node tab
	b. Dbl-click Area2D|area_entered(...)  ( or right-click and chose connect... )
	c. Make sure the Path to Node: .
	d. Method in Node: _on_pitfall_area_entered
	e. Click Connect
5. Save the scene ( ctrl+s )

	
### Adding the birdie(pitfall) scene
We will need:
	art/birdie-0.png
	art/birdie-1.png
	art/birdie-2.png
	art/birdie-3.png
	
1. Menu | Scene | New Inherited Scene...
	a. Pick pitfall.tscn
	b. Rename pitfall to birdie
	c. Save the scene as birdie.tscn
	d. BE AWARE - editing the birdie script is also changing the pitfall script
2. Attach the art/birdie.png to the sprite Texture attribute
	a. Sprite | Frames | [empty] | New Sprite Frames
	b. Sprite Frames | Open Editor
	c. For the default animation, drag in birdie-0.png through birdie-3.png
		ii. Hframes: 4
	b. Node 2D | Transform | Scale
		i.  x: 0.4
		ii. y: 0.4
3. Click on the collision | Shape | [empty]
	a. New RectangleShape2D
	b. Resize the circle with your mouse by pulling on the outer dots.
	c. Inspector | Node2D | Transform | Position
		i.  x: 0 
		ii. y: 0
	d. Lock the sprite and collision together.
	e. Move the two locked items to the middle of the scene
4. Save the scene ( ctrl+s ) and play the scene (F6) not the project - is the bird animated?  YES
	
### Adding birdie to the main scene
1. Open the main scene (main.tscn)
2. Add a child node under main of type Node2D called pitfall_container
3. Open the main script (main.gd)
Working on pitfall code
	

DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	gfx 	http://clipart-library.com/bird-animation.html
			https://jmsliu.com/products/sprite-sheet-decomposer/

