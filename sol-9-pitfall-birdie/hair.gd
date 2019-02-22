extends Area2D

signal hair_grabbed

func _on_hair_area_entered(area):
	if area.name == "player":
		emit_signal("hair_grabbed", $sprite.texture)
		shape_owner_clear_shapes(get_shape_owners()[0])
		queue_free()
