extends Node

@export var explosion_scene : PackedScene = preload("res://scene/explosion.tscn")

var plane_scene : PackedScene #用于选择飞机 表示当前的飞机

#上下界
var up_boundary : int = -181 
var down_boundary : int = 181

#var pre_path : String = "G:/godot/project/project0/test"
var pre_path : String = "res:/"

func create_explosion_with_255_rgb(position,r,g,b,a):
	var explosion_node=explosion_scene.instantiate()
	explosion_node.position=position
	explosion_node.self_modulate=Color( r/255.0, g/255.0, b/255.0,a) #爆炸颜色 必须是百分比的RGB
	get_tree().current_scene.add_child(explosion_node)
	
