extends Node

onready var hair = preload("res://hair.tscn")
onready var hair_container = get_node("hair_container")

var screensize 
var level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screensize = get_viewport().size
	spawn_hair(10)

func spawn_hair(num):
	for i in range(num):
		var h = hair.instance()
		hair_container.add_child(h)
		h.position = Vector2(rand_range(0, screensize.x - 40),
							 rand_range(0, screensize.y - 40))
