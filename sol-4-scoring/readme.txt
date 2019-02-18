Goals:
Pick up treasure, keep score, level increases, limit gameplay time.

### Set up scoring controls
1. On the main scene.  Add a child Control node to the main node named: hud
2. Under hud, add 3 Labels called: score_label, time_label, go_label
3. score_label
	a. Text: 0
	b. Rect | Scale X/Y = 4
	c. Place in top left
4. time_label
	a. Text: 0
	b. Rect | Scale X/Y = 4
	c. Place in top right
5. go_label	
	a. Text: Game Over
	b. Rect | Scalel X/Y = 10
	c. Place in center for X and Y
6. Save the scene ( ctrl+s )
7. Play the Game (F5) - notice Game Over is showing...  What would you change for that not to be the case?
8. Edit the main scene script

...
onready var go_label = get_node("hud/go_label")
...

func _ready():
	...
	randomize()
	go_label.visible = false <- new
	screensize = get_viewport().size
	...
9. Save the scene ( ctrl+s ) / Play the Game (F5) - No more game over!  
	Advantage of this approach over change the property in the inspector?
	
#### Handle collisions / pick up
10. Go to the hair.tscn scene
11. Right click on the hair Area2D, Choose attach script, Create
extends Area2D

signal hair_grabbed

func _on_hair_area_entered(area):
	if area.name == "player":
		emit_signal("hair_grabbed")
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
	
12. Connect the event to the hair Area2D
	a. Click on hair in the scene object list
	b. Where the inspector is, click on the Node tab.
	c. Make sure Signals is selected
	d. Under Area2D, right click on area_entered...
	e. Choose connect...  Below, [] isn't typed, it means it is the default value
		Path to node: [.]   
		Method in node: [_on_hair_area_entered]
	f. Click connect button.
13. Save the scene ( ctrl+s ) / Play the Game (F5) - The hair goes away when you collect it!  

#### Handle the score
14. Go to the main.tscn scene
15. Edit the main script
...
onready var score_label = get_node("hud/score_label")
...
var score = 0
...
func spawn_hair(num):
	for i in range(num):
		var h = hair.instance()
		h.connect("hair_grabbed", self, "_on_hair_grabbed")  <- new
		hair_container.add_child(h)
	...
...
func _on_hair_grabbed():
	score += 10
	score_label.text = str(score)

16. Save the scene ( ctrl+s ) / Play the Game (F5) - Houston we have scoring!  

===================== BREAK/STOP HERE =================

#### Handle hair re-spawn / level up
17. Go to the main.tscn scene
18. Edit the main script
...
func _process(delta):
	if hair_container.get_child_count() == 0:
		level += 1
		spawn_hair(level * 10)
...

19. Save the scene ( ctrl+s ) / Play the Game (F5) - Levelling up works!  

#### Handle time limit
17. Go to the main.tscn scene
18. Add a Timer child node to main called game_timer
19. game_timer	
	a. Wait Time: 30
	b. One Shot: On checked
	c. Autostart: On checked
20. Edit the main script
...
onready var time_label = get_node("hud/time_label")
onready var game_timer = get_node("game_timer")
...
func _process(delta):
	time_label.text = str(int(game_timer.time_left)) <- new
	if gem_container.get_child_count() == 0:
	...
...
func _on_game_timer_timeout():
	get_node("player").set_process(false)
	go_label.visible = true

21. Connect the event to the game_timer Timer
	a. Click on game_time in the scene object list
	b. Where the inspector is, click on the Node tab.
	c. Make sure Signals is selected
	d. Under Timer, right click on timeout()...
	e. Choose connect...  Below, [] isn't typed, it means it is the default value
		Path to node: [..]   
		Method in node: [_on_game_timer_timeout]
	f. Click connect button.
22. Save the scene ( ctrl+s ) / Play the Game (F5) - Time limit is visible and working!  
 



							 
	
DONE!!

NOTE: Unable to write to file...
Click the stop button. Square button near the play scene button.
	
