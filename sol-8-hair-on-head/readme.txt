Goals:
1. Put the last hair picked up on the player's head - need to handle looking left/right.



### Adding the active hair
We will need:
	art/hairless.png
	
1. Open the player scene (player.tscn)
2. Under the player node, at the bottom of the list, add a Sprite called active_hair
	a. Assign the art/hairless.png image to the Texture attribute in the inspector
	b. Under Offset | Offset, set x:0, y:-45
3. Save the scene ( ctrl+s ) / Play the Game (F5) - Do you see the "BALD" hair? YES.  Does it change to the real hair? NO


### Updating the active hair when you pick hair up
1. Open the player scene (player.tscn)
2. Edit the player script
...
onready var trail = get_node("trail")
onready var active_hair = get_node("active_hair")  // new line

var screensize
...
func _ready():
	active_hair.visible = false  // new line
	screensize = get_viewport_rect().size
	...
...
func _process(delta):
	...
	if (vel.length() > 0):
		sprite.flip_h = vel.x < 0
		sprite.play()
		active_hair.flip_h = vel.x < 0  // new line
		trail.emitting = true
	else:
	...
...
func update_active_hair(texture):  // new function
	active_hair.texture = texture
	active_hair.visible = true

3. Open the hair scene (hair.tscn)
4. Edit the hair script
func _on_hair_area_entered(area):
	if area.name == "player":
		emit_signal("hair_grabbed", $sprite.texture) // modified line

	
5. Open the main scene (main.tscn)
6. Edit the main script
...
onready var game_timer = get_node("game_timer")
onready var player = get_node("player")  // new line

var screensize 
...
func _on_hair_grabbed(texture):
	player.update_active_hair(texture)  // new line
	$pick_up.play()
	...
...
7. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the hair update when you collect it? YES


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

