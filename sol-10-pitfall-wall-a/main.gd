extends Node

onready var hair = preload("res://hair.tscn")
onready var hair_container = get_node("hair_container")
onready var go_label = get_node("hud/go_label")
onready var score_label = get_node("hud/score_label")
onready var time_label = get_node("hud/time_label")
onready var game_timer = get_node("game_timer")
onready var player = get_node("player")
onready var pitfall_container = get_node("pitfall_container")
onready var birdie = preload("res://birdie.tscn")
onready var sfx_manager_class = preload("res://sfx_manager.tscn")
onready var wall = preload("res://wall.tscn")

var screensize 
var level = 1
var score = 0
var game_over = false
var sfx_manager = null
var active_pitfalls = {"birdie":{}, "wall":{}}
var object_name_regex = RegEx.new()

signal game_over_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	object_name_regex.compile("@?(?<name>[0-9a-zA-Z]+)@?.*") # objects can be nameed @birdie@30
	randomize()
	$background_music.play()
	go_label.visible = false
	screensize = get_viewport().size
	sfx_manager = sfx_manager_class.instance()
	add_child(sfx_manager)
	build_walls(8, 1)
	spawn_hair(10)
	
func _process(delta):
	time_label.text = str(int(game_timer.time_left)) 
	if hair_container.get_child_count() == 0:
		$level_up.play()
		level += 1
		build_walls(8, 1)
		spawn_hair(level * 10)
	if level >= 1:
		handle_pitfalls()

func build_walls(num, size):
	for i in range(num):
		var w = wall.instance()
		w.connect("pitfall_collided",self,"_on_pitfall_collided")
		self.connect("game_over_signal",w,"_on_game_over")
		pitfall_container.add_child(w)
		active_pitfalls["wall"][w.name] = 1
		w.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))
				
func handle_pitfalls():
	if !game_over:
		if level > 1:
			if active_pitfalls["birdie"].size() == 0:
				var b = birdie.instance()
				b.connect("pitfall_collided",self,"_on_pitfall_collided")
				b.connect("pitfall_off_screen",self,"_on_pitfall_off_screen")
				self.connect("game_over_signal",b,"_on_game_over")
				pitfall_container.add_child(b)
				active_pitfalls["birdie"][b.name] = 1
				b.position = Vector2(rand_range(0, screensize.x - 40),
									 rand_range(0, screensize.y - 40))
				b.seconds_on_screen = 5
	
func _on_pitfall_collided(name, time_impact, score_impact, sfx_collided_name, collision_destroys):
	sfx_manager.play(sfx_collided_name)  
	var new_time_left = 0.1
	new_time_left = clamp(
		game_timer.time_left+time_impact,
		new_time_left,
		game_timer.wait_time)
	game_timer.wait_time = new_time_left
	game_timer.start()
	score += score_impact
	score_label.text = str(score)
	if collision_destroys:
		var safe_name = object_name_regex.search(name).get_string("name")
		if active_pitfalls[safe_name].has(name):
			active_pitfalls[safe_name].erase(name)

		
func _on_pitfall_off_screen(type_name, name):
	var safe_name = object_name_regex.search(name).get_string("name")
	if active_pitfalls[safe_name].has(name):
		active_pitfalls[safe_name].erase(name)

		
func spawn_hair(num):
	for i in range(num):
		var h = hair.instance()
		h.connect("hair_grabbed", self, "_on_hair_grabbed")
		hair_container.add_child(h)
		h.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))

func _on_hair_grabbed(texture):
	player.update_active_hair(texture)
	$pick_up.play()
	score += 10
	score_label.text = str(score)

func _on_game_timer_timeout():
	game_over = true
	emit_signal("game_over_signal", self.name)
	$background_music.stop()
	$go_sfx.play()	
	get_node("player/sprite").stop()
	get_node("player/trail").emitting = false
	get_node("player").set_process(false)
	go_label.visible = true
