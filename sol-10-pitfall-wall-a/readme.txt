Goals for wall:
1. Learn how to have non-moving objects and placing things around them
2. New pitfall - wall
	a. Icon that you cannot pass through - 1 wide or tall ( not diagonal )
		i.   Created when the level first starts
		ii.  How many walls - increase as levels increase?
		iii. They are placed before any other objects
	c. Construction sound effect while walls are building
	d. Stays around for entire level, clears when you change levels
	e. Sound effect when you run into a wall - Uh / Oof
	f. Visual effect when the walls are being created
	g. Change maximum wall length/height as levels increase - should be random from 1 to max
	h. Making sure other things don't get placed on walls
		i.   Hair
		ii.  Birds fly over ;-)
		iii. Other wall pieces


	
###  Wall implementation 10a
###		Icon that you cannot pass through - 1 wide or tall ( not diagonal )

You will need
	art/gfx/wall/tile_bricksRed.png
	
1. Copy the art/gfx/wall/tile_bricksRed.png to your project folder art/gfx/wall directory

2. Create a new wall scene that inherits from pitfall
	a. Scene | New Inherited Scene...
	b. Choose pitfall.tscn
	c. You now have a new unsaved scene
	d. Change the node called pitfall to wall
	e. Save the scene - wall.tscn
	f. Right click on the wall node and choose: Clear Script
	g. Click the Add new or existing script button
		i. Accept defaults and click create
	h. Replace the entire wall.gd script with
extends "res://pitfall.gd"
	
3. Set the wall graphic
	a. Click on the sprite node
	b. In the inspector click on Frames | New Sprite Frames
	c. Click on Sprite Frames
	d. Click Open Editor
	e. Drag in the art/gfx/wall/tile_bricksRed.png
	
4. Create the collision box
	a. Click on the collision node
	b. In the inspector, click on: Shape | New RectangleShape2D
	c. Resize the rectangle to cover the brick image by using the two red balls
		i. You won't want to go all the way out to the edge

5. Save.   You could also play the scene, NOT game, and you will see the brick tile in the upper left corner.

Need to add support for off-screen pitfall notifications.  This will help with tracking 
when certain types of pitfalls have an active count less than X previously we used the 
child count for the pitfall container.  This won't work well as we add more types of 
pitfalls during the same level.

6. Open the pitfall.gd script
  a. Add a pitfall_off_screen signal
signal pitfall_collided
signal pitfall_off_screen  # NEW line
  b. Modify the _process function to send the signal
func _process(delta):
	var set_position = true		
	var pos = position + ( velocity * speed * delta )
	if ((pos.x > screensize.x) or 
	   (pos.x < 0) or
	   (pos.y > screensize.y) or
	   (pos.y < 0)):
		...
		emit_signal("pitfall_off_screen", self.get_class(), self.name) # NEW line
	else:
		if (seconds_on_screen	> 0):
			if (OS.get_ticks_msec() - time_started >= (seconds_on_screen * 1000)):
				...
				emit_signal("pitfall_off_screen", self.get_class(), self.name) # NEW line
	if set_position:
		position = pos

7. Back in the main.gd script
	a. Add 2 new variables
var sfx_manager = null
var active_pitfalls = {"birdie":{}, "wall":{}}  # NEW line
var object_name_regex = RegEx.new() # NEW line
	
	b. Modify handle_pitfalls
 func handle_pitfalls():
	if !game_over:
		if level > 1:
			if active_pitfall_count["birdie"]  == 0:  # CHANGED line
				var b = birdie.instance()
				b.connect("pitfall_collided",self,"_on_pitfall_collided")
				b.connect("pitfall_off_screen",self,"_on_pitfall_off_screen") # NEW line
				self.connect("game_over_signal",b,"_on_game_over")
				pitfall_container.add_child(b)
				active_pitfalls["birdie"][b.name] = 1  # NEW line
				b.position = Vector2(rand_range(0, screensize.x - 40),
									 rand_range(0, screensize.y - 40))
				b.seconds_on_screen = 5
	
	c. Modify _on_pitfall_collided
func _on_pitfall_collided(name, time_impact, score_impact, sfx_collided_name):
	sfx_manager.play(sfx_collided_name)  
	...
	score_label.text = str(score)
	var safe_name = object_name_regex.search(name).get_string("name")  # NEW lines with if
	if active_pitfalls[safe_name].has(name):
		active_pitfalls[safe_name].erase(name)
	
	d. Add a new function
# NEW function
	var safe_name = object_name_regex.search(name).get_string("name")
	if active_pitfalls[safe_name].has(name):
		active_pitfalls[safe_name].erase(name)
	
	e. Modify _ready function
func _ready():
	object_name_regex.compile("@?(?<name>[0-9a-zA-Z]+)@?.*") # objects can be nameed @birdie@30  # NEW line

Save and run
Does the game still work the same? YES
	Do new birds show up when old ones collide or go off screen? YES, YES


Need to add support for pitfalls that don't go away when you run into them

8. Open the pitfall.gd script
	a. Add a new variable
export (String) var sfx_collided_name = ""
export (bool) var collision_destroys = false  # NEW line

	b. modify the on_pitfall_area_entered function - some things moved around and an argument was added to emit_signal
func _on_pitfall_area_entered(area):
	if area.name == "player":
		velocity = Vector2()
		if self.collision_destroys:
			sprite.hide()
			$explosion.show()
			$explosion.play("smoke")
		else:
			emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name, collision_destroys)

	c. modify _on_explosion_animation_finished function
func _on_explosion_animation_finished():
	emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name, collision_destroys)  # ADDED argument to end

9. Open the main.gd script
	a. modify _on_pitfall_collided - new argument to function
func _on_pitfall_collided(name, time_impact, score_impact, sfx_collided_name, collision_destroys):
	...
	if collision_destroys:
		var safe_name = object_name_regex.search(name).get_string("name")
		if active_pitfalls[safe_name].has(name):
			active_pitfalls[safe_name].erase(name)

Save and run
What happens when you run into a birdie?  It just stays there, it doesn't go away.

10. Modify the pitfall.gd script
	a. Change from false to true
export (bool) var collision_destroys = true

Save and run
What happens when you run into the birdie?  It goes away like it used to.
	
/// BELOW HERE start working on walls!	
	
	
6. Open the main.gd script
	a. Add a reference to the wall class
onready var sfx_manager_class = preload("res://sfx_manager.tscn")
onready var wall = preload("res://wall.tscn")  # NEW Line

	b. Add a function to build the walls
func build_walls(num, size):
	for i in range(num):
		var w = wall.instance()
		w.connect("pitfall_collided",self,"_on_pitfall_collided")
		self.connect("game_over_signal",w,"_on_game_over")
		pitfall_container.add_child(w)
		active_pitfalls["wall"][w.name] = 1
		w.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))

	c. Call the build walls on start and level change
func _process(delta):
	time_label.text = str(int(game_timer.time_left)) 
	if hair_container.get_child_count() == 0:
		...
		build_walls(8, 1)  # NEW line
		spawn_hair(level * 10)
	if level >= 1:
		...

func _ready():
	...
	add_child(sfx_manager)
	build_walls(8, 1)  # NEW line
	spawn_hair(10)


Save and run
Do the wall show up?  YES
Do the wall stay in place when you run into them? NO



TODO then make the change that prevents them from going away
	


  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE:
	Brick graphics from: https://kenney.itch.io/kenney-game-assets-3 voxel expansion pack
	Construct Sfx from: https://opengameart.org/content/falling-rock
	Run into sfx from: https://opengameart.org/content/11-male-human-paindeath-sounds
	
NOTE: 
	Content help for this came from 
	sfx:	https://www.youtube.com/watch?v=PNQ5YTP-CUk

