Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for 10 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2a
###		Icon that when you run into it decreases your time

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
var screensize = null
var extents = null


export (int) var time_impact = 0
export (int) var score_impact = 0
export (int) var seconds_on_screen = 10

signal pitfall_collided
	
func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	sprite = $sprite
	sprite.play()

		
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name, time_impact, score_impact)
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

//////////////////////////////// bth left off here 5.1.2019	
	
	
2. Attach the art/birdie...png to the sprite Texture attribute
	a. Sprite | Frames | [empty] | New Sprite Frames
	b. Sprite Frames | Open Editor
	c. For the default animation, drag birdie-0.png ... birdie-3.png
	b. Node 2D | Transform | Scale
		i.  x: 0.4
		ii. y: 0.4
		
3. Click on the collision | Shape | [empty]
	a. New RectangleShape2D
	b. Resize the rectangle with your mouse by pulling on the outer dots.
	c. Inspector | Node2D | Transform | Position
		i.  x: 0 
		ii. y: 0
	d. Lock the sprite and collision together.
	e. Move the two locked items to the middle of the scene

4. While still working on birdie, set the Script Variables | "Time impact" property to: -10 .  Be carefult that you are not on pitfall.

5. Save the scene ( ctrl+s ) and play the scene (F6) not the project - is the bird animated?  YES
	
### Adding birdie to the main scene
1. Open the main scene (main.tscn)
2. Add a child node under main of type Node2D called pitfall_container
3. Open the main script (main.gd)
...
onready var game_timer = get_node("game_timer")
onready var player = get_node("player")
onready var pitfall_container = get_node("pitfall_container") # new line
onready var birdie = preload("res://birdie.tscn") # new line
...

func _process(delta):
	time_label.text = str(int(game_timer.time_left)) 
	if hair_container.get_child_count() == 0:
		$level_up.play()
		level += 1
		spawn_hair(level * 10)
	if level >= 1:   # new line
		handle_pitfalls()  # new line

# new function
func handle_pitfalls():
	if level > 1:
		if pitfall_container.get_child_count() == 0:
			var b = birdie.instance()
			b.connect("pitfall_collided",self,"_on_pitfall_collided")
			pitfall_container.add_child(b)
			b.position = Vector2(rand_range(0, screensize.x - 40),
								 rand_range(0, screensize.y - 40))
	
# new function
func _on_pitfall_collided(name, time_impact, score_impact):
	var new_time_left = 0.1
	new_time_left = clamp(
		game_timer.time_left+time_impact,
		new_time_left,
		game_timer.wait_time)
	game_timer.wait_time = new_time_left
	game_timer.start()
	score += score_impact
	score_label.text = str(score)

6. Save the scene ( ctrl+s ) and run!  Does it work?

7. How could we show birdies starting on level 1?

8. What could we do to lower the score instead of the time?

9. Could we lower the score and the time?

DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	gfx 	http://clipart-library.com/bird-animation.html
			https://jmsliu.com/products/sprite-sheet-decomposer/

