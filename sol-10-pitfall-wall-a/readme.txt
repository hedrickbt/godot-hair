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

6. Open the main.gd script
onready var birdie = preload("res://birdie.tscn")
onready var sfx_manager_class = preload("res://sfx_manager.tscn")
onready var wall = preload("res://wall.tscn")  # NEW Line

func _ready():
	...
	add_child(sfx_manager)
	build_walls(10,1)   # NEW Line...   number of walls, max length
	spawn_hair(10)

TODO: use the handle_pitfalls to create the walls, but will need to add a call to handle_pitfalls in _ready as well

	


  
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

