extends "res://scripts/plane/plane.gd"






func fire() -> void :
	if Input.is_action_pressed("fire") and is_ok_to_fire:
		var bullet_node = bullet_scene.instantiate() 
		bullet_node.position=position+Vector2(0,-11)
		get_tree().current_scene.add_child(bullet_node)
		is_ok_to_fire=false
		fire_Timer.start()
