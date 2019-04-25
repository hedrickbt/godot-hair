Goals:
1. When the player picks up hair, levels up, or hits game over then play a sound
2. Background music


Need
* art/sfx/pick_up_ping.wav
* art/sfx/level_change_ca_ching.wav
* art/sfx/game_over_aaaah_bye.wav
* art/music/awake10_megaWall.ogg

### Adding pick up sound for hair
We will need
art/sfx/pick_up_ping.wav
	
1. Open the main scene (main.tscn)
2. Add a child node under main node of type AudioStreamPlayer
	a. Set the name to pick_up
3. Assign the sound
	a. In the scene tree, click on the new pick_up node
	b. In the inspsector, click on the [empty] under the Stream attribute
	c. Choose Load
	d. Pick res://art/sfx/pick_up_ping.wav
	e. You can tick/checking playing in order to hear it.  Make sure to Uncheck it.	
4. Save the scene ( ctrl+s ) / Play the Game (F5) - Do you expect to hear the sound? NO

### Trigger the sound to play when the hair is picked up
1. Open the main scene
2. Edit the main script
func _on_hair_grabbed():
	$pick_up.play()  // new line
	score += 10
	...
3. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the sound play on pick up? YES

### Adding the level up sound
We will need
art/sfx/level_change_ca_ching.wav
	
1. Open the main scene (main.tscn)
2. Add a child node under main node of type AudioStreamPlayer
	a. Set the name to level_up
3. Assign the sound
	a. In the scene tree, click on the new pick_up node
	b. In the inspsector, click on the [empty] under the Stream attribute
	c. Choose Load
	d. Pick res://art/sfx/level_change_ca_ching.wav
	e. You can tick/checking playing in order to hear it.  Make sure to Uncheck it.	
4. Where would you put the code to activate the level up sound?
5. Edit the main scene main script
func _process(delta):
	time_label.text = str(int(game_timer.time_left)) 
	if hair_container.get_child_count() == 0:
		$level_up.play()   // new line
		level += 1
		...
6. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the sound play on level up?

### Adding the game over sound
We will need
art/sfx/game_over_aaaah_bye.wav
	
1. Open the main scene (main.tscn)
2. Add a child node under main node of type AudioStreamPlayer
	a. Set the name to go_sfx
3. Assign the sound
	a. In the scene tree, click on the new pick_up node
	b. In the inspsector, click on the [empty] under the Stream attribute
	c. Choose Load
	d. Pick res://art/sfx/game_over_aaaah_bye.wav
	e. You can tick/checking playing in order to hear it.  Make sure to Uncheck it.	
4. Where would you put the code to activate the game over sound?
5. Edit the main scene main script
...
func _on_game_timer_timeout():
	$go_sfx.play()	// new line
	get_node("player/sprite").stop()
	...
	
6. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the game over sound play?


### Adding the background music
We will need
art/music/awake10_megaWall.ogg
	
1. Open the main scene (main.tscn)
2. Add a child node under main node of type AudioStreamPlayer
	a. Set the name to background_music
3. Assign the sound
	a. In the scene tree, click on the new pick_up node
	b. In the inspsector, click on the [empty] under the Stream attribute
	c. Choose Load
	d. Pick res://art/music/awake10_megaWall.ogg
	e. Make sure the loop attribute is checked.  Go to the import tab ( next to the scene tab on the scene tree )
	f. You can tick/checking playing in order to hear it.  Make sure to Uncheck it.	
4. Where would you put the code to activate/deactivate the background music?
5. Edit the main scene main script
...
func _ready():
	randomize()
	$background_music.play()  // new line
	go_label.visible = false
	...
...
func _on_game_timer_timeout():
	$background_music.stop() // new line
	$go_sfx.play()	
	...
	
6. Save the scene ( ctrl+s ) / Play the Game (F5) - Does the background music play?

DONE!!

NOTE: 
	Unable to write to file...
	Click the stop button. Square button near the play scene button.

NOTE: 
	Content help for this came from 
	godot:	https://www.youtube.com/watch?v=L-GVq8Lvllo&list=PLsk-HSGFjnaFutTDzgik2KMRl6W1JxFgD&index=6
	sfx:	https://www.youtube.com/watch?v=JY6kfsqpReY
	music:	https://opengameart.org/

NOTE:  
	$ vs get_node - should store in variables due to scene path changes otherwise....
	It doesn’t matter! But I’ve been using $, because it takes less typing to get the fuzzy autocompletion to appear. 
	With get_node() you have to type get_node(" before it tries to guess a node.

	More important than arguing over which one to use is making sure that you’re not repeating yourself in code.

	https://oneshotrpg.com/tutorial/werewolf-style-game/dollar-sign-vs-get-node/


	
