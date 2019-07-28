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
