Goals for birdie:
1. Learn how to handle scene inheritance - to save time/typing and avoid mistakes
2. New pitfall - birdie
	a. Icon that when you run into it decreases your time
	b. Icon that moves around haphazardly
	c. Tweeting bird sound effect
	d. Stays around for at most 5 seconds
	e. Sound effect when you run into the birdie
	f. Visual effect when you run into the birdie


	
###  Birdie implementation 2e
###		Sound effect when you run into the birdie

You will need
	art/sfx/hit_birdie.wav
	
Create a new scene sfxmanager.tscn to manage sound effects : issues with using effects attached to objects that go away!
1. Create a new scene
	a. Scene | New scene | 2D Scene
	b. Rename Node2D element to sfx_manager
	c. Save the scene: sfx_manager.tscn
2. Add a new Audio Stream Player under the sfx_manager Node2D called player_collide_birdie
	a. Assign the art/sfx/hit_birdie.wav as the collide_sfx.stream
	b. Autoplay On: unchecked
	c. Playing On: Unchecked
3. Attach a script to the sfx_manager Node2D node
	a. Accept defaults
	b. Create
4. sfx_manager.gd code
extends Node2D

func _ready():
	randomize()
	# play() # This just make a nice/easy way to test this module when starting up
	
func play(sfx_node_name = null):
	if sfx_node_name:
		get_node(sfx_node_name).play()
	else:
		# This just make a nice/easy way to test this module when starting up
		var c = randi() % get_child_count()
		get_child(c).play()
		
func stop(sfx_node_name = null):
	if sfx_node_name:
		get_node(sfx_node_name).stop()
	else:
		var child_count = get_child_count()
		for i in range(child_count):
			get_child(i).stop()

Modify the pitfall script to support a collided sound effect
1. Open pitfall.gd
2. Add
export (int) var score_impact = 0
export (int) var seconds_on_screen = 0
export (String) var sfx_collided_name = "" // NEW line

Modify the birdie script to specify the collided sound effect name
1. Open the birdie.gd
2. Add
func _ready():
...
	velocity.y = rand_range(0.2,100) * y_multiply
	speed = rand_range(0.2,5)
	sfx_collided_name = "player_collide_birdie" // NEW line

Modify the pitfall scene to pass the collided sfx back on it emit signal for collision
1. Open the pitfall.gd
2. Modify
func _on_pitfall_area_entered(area):
	if area.name == "player":
		emit_signal("pitfall_collided", self.name, time_impact, score_impact, sfx_collided_name) // CHANGE line


Modify the main scene to trigger the new sound effect
1. Open the main.gd script
2. Add
onready var pitfall_container = get_node("pitfall_container")
onready var birdie = preload("res://birdie.tscn")
onready var sfx_manager_class = preload("res://sfx_manager.tscn") // NEW Line

var score = 0
var game_over = false
var sfx_manager = null // NEW Line

3. Modify / Add
func _ready():
	...
	screensize = get_viewport().size
	sfx_manager = sfx_manager_class.instance() // NEW line
	add_child(sfx_manager) // NEW line - will run without error, but will not play the sound without this 

func _on_pitfall_collided(name, time_impact, score_impact, sfx_collided_name):  // CHANGE line
	sfx_manager.play(sfx_collided_name)  // NEW line
	...


Time to test
1. Save and run
2. Do you heard the gargling sound effect when the play runs into a birdie? YES


  
DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	sfx:	https://www.youtube.com/watch?v=PNQ5YTP-CUk

