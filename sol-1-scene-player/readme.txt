Goal:
Create a player scene where you can use the keyboard to move the player around

1. Add a scene ( use the empty one if it starts up that way )
2. Add a node: Area2D / player
	a. Add a node: Sprite / sprite
	b. Attach the art/running_standin_1.png to the sprite.Texture via Drag-N-Drop
3. Save the scene as: player.tscn
4. Play the scene
5. Note the position of the player - move the the player to the top right of the "screen".
	be sure to select area around the sprite not just the sprite.
6. Save ( ctrl+s )
7. Play the scene ( F6 )
8. Attach a script to the player node.  Right-Click | Attach Script, create
9. Clear out everything except
===============================
extends Area2D

var screensize

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
===============================	

10. Save
11. Play the scene
12. Note where the player ended up.
13. Update the same code - testing out positions
===============================
extends Area2D

var screensize

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = position.x + 1
	input.y = position.y + 2
	
	position = input
===============================	

14. What will this do?
15. Save and Play scene
15.a. What's a Vector2?
16. Update the same code - testing out input
===============================
extends Area2D

var screensize

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	position = position + input
===============================	

17. Talk about the is_action_pressed, boolean, int, positive/negative.
18. Save and Play
19. How would you handle the Y direction?
20. Code changes for the Y direction
===============================	
extends Area2D

var screensize

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	position = position + input
===============================	

21. Save and Play
22. Code changes for velocity and speed
===============================	
extends Area2D

var screensize
var speed = 400
var vel = Vector2()

func _ready():
	screensize = get_viewport_rect().size
	position = screensize / 2
	
func _process(delta):
	var input = Vector2()
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	vel = input.normalized() * speed
	var pos = position + ( vel * delta )
	
	position = pos
===============================	

23. Save and Play
24. What is normalized?
Normalizing a vector means reducing its length to 1 while preserving its direction
https://docs.godotengine.org/en/3.0/tutorials/math/vector_math.html
25.  What is delta? 
It is the amount of time between frames - helps adjust for non-60 FPS times

DONE!!!!!

NOTE: Unable to write to file...
Click the stop button. Square button near the play scene button.
	
NOTE: 
	default dimensions = 1024, 600
	default FPS = 60

