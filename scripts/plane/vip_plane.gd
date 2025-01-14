extends "res://scripts/plane/plane.gd"

func fire() -> void :
	if Input.is_action_pressed("fire") and is_ok_to_fire:
		
		var bullet_distance = 10 #三个子弹之间的间隔
		
		for i in range(3):
			var bullet_node = bullet_scene.instantiate() 
			bullet_node.position=position+Vector2(-bullet_distance+bullet_distance*i,-11)
			get_tree().current_scene.add_child(bullet_node)
		
		is_ok_to_fire=false
		fire_Timer.start()
