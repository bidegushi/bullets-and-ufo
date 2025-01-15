extends Node

const start_scene = preload("res://scene/real_scene/strat_page.tscn")
const plane_selector_scene = preload("res://scene/real_scene/plane_selector.tscn")
var main_scene = preload("res://scene/real_scene/main.tscn")

const loadding_scene = preload("res://scene/real_scene/loadding_scene.tscn")


func change_scene(scene_name:String) ->void:
	var scene_to_load
	match scene_name:
		"start_page":
			scene_to_load=start_scene
		"plane_selector":
			scene_to_load=plane_selector_scene	
		"main":
			scene_to_load=main_scene
		
	if scene_to_load != null :
		get_tree().change_scene_to_packed(scene_to_load)

func change_to_main(plane_name:String) -> void:
	var scene_to_load
	scene_to_load=main_scene.instantiate()
	
	match plane_name:
		"plane":
			Global.plane_scene=load("res://scene/plane/plane.tscn")
		"vip_plane":
			Global.plane_scene=load("res://scene/plane/vip_plane.tscn")
		"blue_plane":
			Global.plane_scene=load("res://scene/plane/blue_plane.tscn")
	change_scene("main")
