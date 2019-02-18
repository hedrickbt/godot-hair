extends Node

onready var hair = preload("res://hair.tscn")
onready var hair_container = get_node("hair_container")
onready var go_label = get_node("hud/go_label")
onready var score_label = get_node("hud/score_label")
onready var time_label = get_node("hud/time_label")
onready var game_timer = get_node("game_timer")

var screensize 
var level = 1
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$background_music.play()
	go_label.visible = false
	screensize = get_viewport().size
	spawn_hair(10)
	
func _process(delta):
	time_label.text = str(int(game_timer.time_left)) 
	if hair_container.get_child_count() == 0:
		$level_up.play()
		level += 1
		spawn_hair(level * 10)


func spawn_hair(num):
	for i in range(num):
		var h = hair.instance()
		h.connect("hair_grabbed", self, "_on_hair_grabbed")
		hair_container.add_child(h)
		h.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))

func _on_hair_grabbed():
	$pick_up.play()
	score += 10
	score_label.text = str(score)

func _on_game_timer_timeout():
	$background_music.stop()
	$go_sfx.play()	
	get_node("player/sprite").stop()
	get_node("player/trail").emitting = false
	get_node("player").set_process(false)
	go_label.visible = true
