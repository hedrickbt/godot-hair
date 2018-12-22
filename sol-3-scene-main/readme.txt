Goal:
Create a main scene - this will be our controller!

1. Add a scene 
2. Add a node: Node / main
	a. Right-click main and choose "Instance child scene"
	b. Choose the player scene (player.tscn)
3. Save the scene as: main.tscn ( ctrl+s )
4. Play the Game (triangle button - not the scene/movie button)
5. You will be prompted that no main scene has been defined.  Press the SELECT button and choose main.tscn
	NOTE:  This can also be changed via: Project Settings | Application | 
6. Do your arrow keys work for movement?  They should.  Is movement limited to the screen?  It should be.
7. Add a child Node2D to main called hair_container
8. Right click on main, choose attach script, click Create
extends Node

onready var hair = preload("res://hair.tscn")
onready var hair_container = get_node("hair_container")

var screensize 
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().size
	spawn_hair(10)

func spawn_hair(num):
	for i in range(num):
		var h = hair.instance()
		hair_container.add_child(h)
		h.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))

9. Save the scene ( ctrl+s )
10. Play the Game (F5)
11. Play the Game a few times - what do you notice about the hair?  Is it random?
12. We need to make one small change to the game script...
func _ready():
	randomize() <- added this line
	screensize = get_viewport().size
	spawn_hair(10)
13. Save the scene ( ctrl+s )
14. Play the Game (F5) - now how does the hair look?

							 
	
DONE!!

NOTE: Unable to write to file...
Click the stop button. Square button near the play scene button.
	
