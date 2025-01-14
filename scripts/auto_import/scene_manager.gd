extends Node

const start_scene = preload("res://scene/real_scene/strat_page.tscn")
const main_scene = preload("res://scene/real_scene/main.tscn")

const loadding_scene = preload("res://scene/real_scene/loadding_scene.tscn")


func change_scene(scene_name:String) ->void:
	var scene_to_load
	match scene_name:
		"start_page":
			scene_to_load=start_scene
		"main":
			scene_to_load=main_scene
		
	if scene_to_load != null :
		get_tree().change_scene_to_packed(scene_to_load)

func change_to_main(plane_name:String) -> void:
	var scene_to_load
	scene_to_load=main_scene
	match plane_name:
		"plane":
			pass
	
