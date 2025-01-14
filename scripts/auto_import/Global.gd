extends Node

@export var explosion_scene : PackedScene = preload("res://scene/explosion.tscn")

func create_explosion_with_255_rgb(position,r,g,b,a):
	
	var explosion_node=explosion_scene.instantiate()
	explosion_node.position=position
	explosion_node.self_modulate=Color( r/255.0, g/255.0, b/255.0,a) #爆炸颜色 必须是百分比的RGB
	get_tree().current_scene.add_child(explosion_node)
	
